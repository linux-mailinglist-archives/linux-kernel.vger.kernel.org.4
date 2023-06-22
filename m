Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72A73A617
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFVQ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFVQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:29:15 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB061BD9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:28:30 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7653bd3ff2fso52678285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687451310; x=1690043310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAMXHttBEpnNDM1/PVpXSoGpMwQvu/f70ID06t9hTiU=;
        b=a0LThZxi0hocE0ZRI6X+qs1ketmetpqrSLc6vLuF+Yqm3l7zPidWKM8puccLnd3gQs
         YaKdcviBa9Z5UDkslRP+32XdVN/2fmW61ABK3zq05hyaMXjgDAMlc+J3agCPk2XdIn53
         BTsr94f5p3mGmz9UXeRAfEhFVGYTC/AuxuS+Nu0TrnNtJpnSO2ZiyZ20NzjtFMwOfAdK
         D9HvCz6Ck8jNF5GbkcfihXH9ErfadA6BN1RJaD6b7S3BjeQK4jY9db1AgRnUcfv0kcLt
         fNsGwGeUlWIQEoDb1Lfgh7Ce8VjX+Mqh7/C+pD/ezBL4Vo3IxgkwETrkf3TCD8LuiuA+
         Q/dw==
X-Gm-Message-State: AC+VfDzkscv6f4Vzu1P1rOtnnO6r0ZlsImE3goEBP+/mIfcGNMpv0khn
        hQYjV+JHnJzd+eoo5qz1AkjG
X-Google-Smtp-Source: ACHHUZ7p4DG4k30IC0D47LxEx/ITMdNMqVumDmArxV9J1Z5ICIuIa8XyBD7+Oxa3DSu7k7IRBmyJHg==
X-Received: by 2002:a05:620a:1a87:b0:762:1f9:648b with SMTP id bl7-20020a05620a1a8700b0076201f9648bmr13356035qkb.18.1687451309870;
        Thu, 22 Jun 2023 09:28:29 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a128900b007339c5114a9sm3523476qki.103.2023.06.22.09.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:28:29 -0700 (PDT)
Date:   Thu, 22 Jun 2023 12:28:28 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        mpatocka@redhat.com
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] device-mapper: Check that target specs are
 sufficiently aligned
Message-ID: <ZJR2rGZw0Ddf3TFK@redhat.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
 <20230603145244.1538-1-demi@invisiblethingslab.com>
 <20230603145244.1538-2-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603145244.1538-2-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03 2023 at 10:52P -0400,
Demi Marie Obenour <demi@invisiblethingslab.com> wrote:

> Otherwise subsequent code will dereference a misaligned
> `struct dm_target_spec *`, which is undefined behavior.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> ---
>  drivers/md/dm-ioctl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index cc77cf3d410921432eb0c62cdede7d55b9aa674a..34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1394,6 +1394,13 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
>  static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
>  		       struct dm_target_spec **spec, char **target_params)
>  {
> +	static_assert(_Alignof(struct dm_target_spec) <= 8,
> +		      "struct dm_target_spec has excessive alignment requirements");

Really not sure what you mean by "has excessive alignment requirements"...

> +	if (next % 8) {
> +		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
> +		return -EINVAL;
> +	}
> +
>  	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
>  	*target_params = (char *) (*spec + 1);
>  

But this patch and patches 2 and 3 need more review. I'd like Mikulas to review.

I did pick up patches 4-6 for the upcoming 6.5 merge window.

Note, please prefix with "dm ioctl" instead of "device-mapper".

(I just switched my "dm" prefix to "dm ioctl" and forced update on the
dm-6.5 branch, so the commit I referenced earlier for your version
copy patch is now here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.5&id=a5a3de762b3ae8959347928843c12502b1b23163
)

Mike
