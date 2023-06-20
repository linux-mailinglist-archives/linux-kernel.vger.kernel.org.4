Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91D873657D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjFTH6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFTH55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:57:57 -0400
Received: from smtp.tom.com (smtprz25.163.net [106.38.219.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD072188
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:57:30 -0700 (PDT)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id AE066B00D42
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:57:28 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID 217593003
          for <linux-kernel@vger.kernel.org>;
          Tue, 20 Jun 2023 15:57:28 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id 7A50DB00D3F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:57:28 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1687247848; bh=fe2gbNBOimrCNd/Vj8kpZhrYgncj1cjN6H+eAQuu4MY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xlg98piG1s6bLBhNbXo7UBieV60r1wHPRuUNk7mBSncadT5C1LDiUEt+ERH1ZlZ4v
         sPBIdHPT0N4B0m3KavXQL9d7eRznnDDxDo2eEhstuuP6RvFTmWddN7DkXKh/qh7UxE
         Lcn6leovUXh2QV5XP9BoY42LSK3PSJ+rsDl1C8IU=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id A76FAD41AF8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:57:26 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y1DeYHpzuQ3q for <linux-kernel@vger.kernel.org>;
        Tue, 20 Jun 2023 15:57:25 +0800 (CST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by antispam1.tom.com (Postfix) with ESMTPA id D096BD4140C;
        Tue, 20 Jun 2023 15:57:22 +0800 (CST)
Message-ID: <c12c4031-52fb-25a2-b411-e668eb9baaa2@tom.com>
Date:   Tue, 20 Jun 2023 15:57:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amd/amdgpu: Properly tune the size of struct
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Su Hui <suhui@nfschina.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, Xinhui.Pan@amd.com,
        daniel@ffwll.ch, David.Francis@amd.com, Jane.Jian@amd.com,
        Bokun.Zhang@amd.com, monk.liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20230620045919.492128-1-suhui@nfschina.com>
 <da6c860f-0ef0-44e4-8b58-0f4d55c1b8bd@kadam.mountain>
From:   Longsuhui <Jack_sun@tom.com>
In-Reply-To: <da6c860f-0ef0-44e4-8b58-0f4d55c1b8bd@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/20 15:37, Dan Carpenter wrote:
> On Tue, Jun 20, 2023 at 12:59:19PM +0800, Su Hui wrote:
>> Smatch error:
>>      gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:316:49: error:
>>      static assertion failed: "amd_sriov_msg_pf2vf_info must be 1 KB"
>>      static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>>
> I doubt that moving the struct members around is safe.  This looks like
> it's in a very specific order.  So I don't think this patch is correct.
>
> The reason for this false positive this code uses a #pragma to pack the
> struct.
>
> #pragma pack(push, 1) // PF2VF / VF2PF data areas are byte packed

Oh, Sorry, I didn't see this code.

This patch is error, and sorry for the noise.

> Sparse does not support this and Smatch uses Sparse as a parser.  The
> main reason why Sparse doesn't support this pragma is because Linus
> thinks it's gross.  You probably didn't even see the #pragma did you?
> And anything you can't see is unreadable by definition.
>
> "Mark the associated types properly packed individually, rather than
> use the disgusting "pragma pack()" that should never be used."
>
> https://lore.kernel.org/linux-sparse/CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com/
>
> regards,
> dan carpenter
