Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61250625F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiKKQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiKKQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:16:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1647A658C;
        Fri, 11 Nov 2022 08:16:56 -0800 (PST)
Received: from zn.tnic (p200300ea9733e727329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e727:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47D7E1EC042F;
        Fri, 11 Nov 2022 17:16:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668183414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eMsQDKWlL6uraJj5HUJ5zGvCAF7tvNGuIrG9jb/77bQ=;
        b=VyMmcjUcFzrEj87XvYgjPWlJQ/nyBUi8rvS6Ssa/rQLLvz5ySP90o3+lLi470c2UGCJH4Q
        XHMNVCYWD8K8q5Bdj+yxPeozoc4uL0Sna1f5+BEWGNiCz8qNA230r0nmeJxcwutsJB+XOh
        w1RL933kcSGlhMUDsr4IHlBsuIY72JE=
Date:   Fri, 11 Nov 2022 17:16:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
Subject: Re: [PATCH v2 08/14] platform/x86/intel/ifs: Add metadata support
Message-ID: <Y251cGhb+x7Lqk9W@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-9-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107225323.2733518-9-jithu.joseph@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:53:17PM -0800, Jithu Joseph wrote:
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index 89ce265887ea..60ba5a057f91 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -44,6 +44,38 @@ static const char * const scan_authentication_status[] = {
>  	[2] = "Chunk authentication error. The hash of chunk did not match expected value"
>  };
>  
> +#define META_TYPE_END		(0)

MC_HEADER_META_TYPE_END

> +
> +struct metadata_header {
> +	unsigned int		type;
> +	unsigned int		blk_size;
> +};
> +
> +static struct metadata_header *ifs_find_meta_data(void *ucode, unsigned int meta_type)

It's a static function - no need for the ifs_ prefix.

> +{
> +	struct metadata_header *meta_header;
> +	unsigned long data_size, total_meta;
> +	unsigned long meta_size = 0;
> +
> +	data_size = get_datasize(ucode);
> +	total_meta = ((struct microcode_intel *)ucode)->hdr.metasize;
> +


^ Superfluous newline.

> +	if (!total_meta)
> +		return NULL;
> +
> +	meta_header = (ucode + MC_HEADER_SIZE + data_size) - total_meta;
> +
> +	while ((meta_header->type != META_TYPE_END) && meta_header->blk_size &&

You don't need the brackets.

> +	       meta_size < total_meta) {

And you can align all three conditions vertically for better readability:

        while (meta_header->type != META_TYPE_END && 
               meta_header->blk_size &&
               meta_size < total_meta) {

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
