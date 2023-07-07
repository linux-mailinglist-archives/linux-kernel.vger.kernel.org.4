Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8B74A902
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjGGC2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjGGC16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:27:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370051BE8;
        Thu,  6 Jul 2023 19:27:54 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qxy1C569SzPjwB;
        Fri,  7 Jul 2023 10:25:35 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 7 Jul
 2023 10:27:49 +0800
Message-ID: <b5628a5d-e496-822b-b3ac-4a15b228e7b5@huawei.com>
Date:   Fri, 7 Jul 2023 10:27:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 07/20] selinux: services: update type for umber of
 class permissions
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
CC:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
References: <20230706132337.15924-1-cgzones@googlemail.com>
 <20230706132337.15924-7-cgzones@googlemail.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <20230706132337.15924-7-cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

First of all, there's a typo in the subject: umber -> number ;)

On 2023/07/06 21:23, Christian Göttsche wrote:
> Security classes have only up to 32 permissions, hence using an u16 is
> sufficient (while improving padding).
> 
> Also use a fixed sized cast in a bit shift to work correctly on
> architectures where sizeof(unsigned int) != sizeof(u32).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 6 +++---
>  security/selinux/ss/services.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 78946b71c1c1..3275cfe2c8f7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -97,7 +97,6 @@ static int selinux_set_mapping(struct policydb *pol,
>  			       struct selinux_map *out_map)
>  {
>  	u16 i, j;
> -	unsigned k;
>  	bool print_unknown_handle = false;
>  
>  	/* Find number of classes in the input mapping */
> @@ -117,6 +116,7 @@ static int selinux_set_mapping(struct policydb *pol,
>  	while (map[j].name) {
>  		const struct security_class_mapping *p_in = map + (j++);
>  		struct selinux_mapping *p_out = out_map->mapping + j;
> +		u16 k;
>  
>  		/* An empty class string skips ahead */
>  		if (!strcmp(p_in->name, "")) {
> @@ -202,7 +202,7 @@ static void map_decision(struct selinux_map *map,
>  {
>  	if (tclass < map->size) {
>  		struct selinux_mapping *mapping = &map->mapping[tclass];
> -		unsigned int i, n = mapping->num_perms;
> +		u16 i, n = mapping->num_perms;
>  		u32 result;
>  
>  		for (i = 0, result = 0; i < n; i++) {
> @@ -230,7 +230,7 @@ static void map_decision(struct selinux_map *map,
>  		 * should audit that denial
>  		 */
>  		for (; i < (sizeof(u32)*8); i++)
> -			result |= 1<<i;
> +			result |= 1<<((u32)i);

Is it really necessary to do explicit conversion here? Its value is
known to be small, and IIUC, u16 will be implicitly promoted to int as
an operand of <<, as described here:

https://en.cppreference.com/w/c/language/conversion#Integer_promotions

>  		avd->auditdeny = result;
>  	}
>  }
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
> index 8a9b85f44b66..b6f99353301e 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -12,7 +12,7 @@
>  /* Mapping for a single class */
>  struct selinux_mapping {
>  	u16 value; /* policy value for class */
> -	unsigned int num_perms; /* number of permissions in class */
> +	u16 num_perms; /* number of permissions in class */
>  	u32 perms[sizeof(u32) * 8]; /* policy values for permissions */
>  };
>  
