Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453B871F0E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjFARf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFARfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:35:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014E5134
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:35:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d247a023aso845600b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685640954; x=1688232954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVGMREsWzO1c/sNV3gmLzKlvHUynvxsJtWsx11SaIbs=;
        b=wZGzjXotCrJNzs6y2cgRlaw5IBrRhWt0Z7ZPML9GorT6fZQ3GU9ZwUAaI7PYjUDQVy
         wOuqdAueAayn1y6abPJJoiJr8RKSBeyA7sKkImyrhV1KHsxQ1614UAt//eXUFm9kkJys
         SLERr9Ofld00I5Gz3lfvKAppcLOfz+J7z5xiKqARZFKesQmyxykzKwLvOnbW/dHEoyyo
         P7/dbb4J1s4pepzSF55KH4BtIR91FGMKuaw8R1b2HMUrWq2UfH/RjX7Au59k8652+nqN
         OzWFsUH1JhreWKsJJs4bXQgqqdGN5T7nog+xz1a5dWs1Zl4EEkfN9M2bJu/y5Fq6Swt/
         coeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685640954; x=1688232954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVGMREsWzO1c/sNV3gmLzKlvHUynvxsJtWsx11SaIbs=;
        b=gpmcpUtkBCW9S+r8m9gHKOiU9KyEDs0wWSDFaNsIcoXYdUm7SJzWDWjzyLP/FMiue5
         5oHdogjjQH3kfZjIeR35b4OqgrDLbcTuyfaXpCU8wa8FJ7Gv0g3yueXJb2dv/2oOigkN
         qrwLg/pRQ01eYBlARTl/kMaHdYUV9n5AWW5e4iPIPmNEmlcWIBLFbxP37jYOIPs6MbqB
         S5CZDPMv121cLzfp3jX323BnDARWjlh/PRlBFViu0KSfNg6JqWm8/INiCEmYegevk891
         nfRfa/KKaZQO4AemuYUbwiNV1BP3lwIay6fZfHfCTS5HKCa7vTPSUnJT11yvVCMuac61
         UTGg==
X-Gm-Message-State: AC+VfDy6E7ULqgPHdVcz/mzCAjXScSFMB9u0gjKyeAUAQCbQpYp7x45m
        T6xI7G0V5gxve30WXylgQze8Bw==
X-Google-Smtp-Source: ACHHUZ51vbDxBWBcgm+efybO7lW68d64nZiJTizcRZ9cY1kdV2hxbgulcI1/JGkC1hoUMMmyGgSpGQ==
X-Received: by 2002:a05:6a00:2295:b0:64c:c5f9:1533 with SMTP id f21-20020a056a00229500b0064cc5f91533mr9662058pfe.33.1685640954214;
        Thu, 01 Jun 2023 10:35:54 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b00634dde2992bsm5288998pfh.132.2023.06.01.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 10:35:53 -0700 (PDT)
Date:   Thu, 1 Jun 2023 17:35:49 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Jialu Xu <xujialu@vimux.org>
Cc:     gregkh@linuxfoundation.org, cristian.ciocaltea@collabora.com,
        masahiroy@kernel.org, vipinsh@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/tags.sh: improve compiled sources generation
Message-ID: <ZHjW9RJ/jinVe5F/@google.com>
References: <20230601010402.71040-1-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601010402.71040-1-xujialu@vimux.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 09:04:02AM +0800, Jialu Xu wrote:
> Use grep instead of sed for all compiled sources generation, it is three
> times more efficient.

Although I'm not sure how you obtained a 3x efficiency it did make
things faster for me. I suppose there are several factors involved.
I used defconfig for arm64 and got the following results:
	real    1m50.790s
	real    1m27.907s (with patch)

Tested-by: Carlos Llamas <cmllamas@google.com>

> 
> Signed-off-by: Jialu Xu <xujialu@vimux.org>
> ---
>  scripts/tags.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index ea31640b2671..938dba219534 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -98,7 +98,7 @@ all_compiled_sources()
>  	{
>  		echo include/generated/autoconf.h
>  		find $ignore -name "*.cmd" -exec \
> -			sed -n -E 's/^source_.* (.*)/\1/p; s/^  (\S.*) \\/\1/p' {} \+ |
> +			grep -Poh '(?<=^  )\S+|(?<== )\S+[^\\](?=$)' {} \+ |
>  		awk '!a[$0]++'
>  	} | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
>  	sort -u
> -- 
> 2.30.2
> 
