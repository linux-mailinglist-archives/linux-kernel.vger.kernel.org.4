Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365287255D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjFGHgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbjFGHfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:35:45 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 00:34:31 PDT
Received: from smtpdh19-1.aruba.it (smtpdh19-1.aruba.it [62.149.155.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4081BE4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:34:31 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 6nfbqxSUNBHmg6nfbqYsfQ; Wed, 07 Jun 2023 09:33:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1686123207; bh=6BOAWa6skAWoa3xgLfnmgkeGr2K9HUOFJEmthuXgIns=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=KTN8PlVkP9NkGa1UjzQHChP7SfZWN0L2vXNku9dcrDeJfOutwolxWOmKXZHyepEeO
         1yNbGDSdq6686iFTdjeufqf9H1SUQmLHdhBrHr+3RCpu0NZxzFF1HYM7O+0Kfzaqo6
         j+diMs44TjwneInLVCOMpSWaEEqPla87f/welhWpaC06ebOOehT683eLIx8zyq1FAa
         yel+9hZKxu4CE/rzMIs0euYDlIxKGArSDfSh00vWzzg5s1ifxTZ4FuOXBRAnjL/XyS
         +j159MB1qxiXHKl5Nf09z+tp1UFiystn1ElEzpmu0YujZT2JHKbXWhsiWZ3oIxJr5x
         3/DmTViAJrKCA==
Message-ID: <fe435e68-8e05-9078-0fe6-63ef7cce2fc9@enneenne.com>
Date:   Wed, 7 Jun 2023 09:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] pps: Increase PPS_MAX_SOURCES value.
Content-Language: en-US
To:     Charlie Johnston <charlie.johnston@ni.com>
Cc:     linux-kernel@vger.kernel.org, brenda.streiff@ni.com
References: <20230605203147.694716-1-charlie.johnston@ni.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20230605203147.694716-1-charlie.johnston@ni.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLTYkMUEuW2vhxsNEeroTMJhjNfA9K0/XOUHaTLQVev1GSrinW6jBgBBc8C2R3YM1kvS9Ngb2CQeA/BKEikt2I3QfP5JjeKDKROj/zEI9vy/KxxxnHaG
 RWPFoNJ/uOu7uk/zDmzekwzI18G+9Gb/fJ883STb+2EqwIfZa6h/ssLqXteCcMC88X/UAmQiUpdrcW5cfV+Y/v/woNh2WVFN1QUVC4n2QnRcFqpLTWjZ3qjZ
 LDjvczs3uYknKNKt3Nq4rmAK88vkPVnMWZX+1ZsZSys=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/23 22:31, Charlie Johnston wrote:
> For consistency with what ptp uses for minors, this
> change sets PPS_MAX_SOURCES to MINORMASK + 1.
> 
> The PPS_MAX_SOURCES value is currently set to 16. In
> some cases this was not sufficient for a system. For
> example, a system with multiple (4+) PCIe cards each
> with 4 PTP-capable ethernet interfaces could run out
> of the available PPS major:minors if each interface
> registers a PPS source.
> 
> Signed-off-by: Charlie Johnston <charlie.johnston@ni.com>
> ---
>   include/uapi/linux/pps.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
> index 009ebcd8ced5..85f472330da8 100644
> --- a/include/uapi/linux/pps.h
> +++ b/include/uapi/linux/pps.h
> @@ -26,7 +26,7 @@
>   #include <linux/types.h>
>   
>   #define PPS_VERSION		"5.3.6"
> -#define PPS_MAX_SOURCES		16		/* should be enough... */
> +#define PPS_MAX_SOURCES		(MINORMASK + 1)
>   
>   /* Implementation note: the logical states ``assert'' and ``clear''
>    * are implemented in terms of the chip register, i.e. ``assert''

I have just one question: are you sure that it's safe to call idr_alloc(..., 0, 
(MINORMASK + 1), ...)?

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

