Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14416FBB00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjEHWYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEHWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:24:32 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AEF5B94
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 15:24:29 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ab087111faso545892a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1683584669; x=1686176669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oh4cYdpA3zHXGiDsi1iCqMmPF0iLCUhn6fPa0sIu8Zo=;
        b=U8XflA4Ds1uBfVg3LgIiAcij7LJm2QUNFOuwudW7z8kRPYj08VO00fJq6FHWN/GX+g
         xTNe8UK/UfssfW+36rNaZAFPHbtZ/KL4qxhXgcbL71EftF411Z7BwB5pQvGSc9MEPTjV
         niwHqGSfPmgAKfRD7RkooV25see+Bll9ZPIQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683584669; x=1686176669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh4cYdpA3zHXGiDsi1iCqMmPF0iLCUhn6fPa0sIu8Zo=;
        b=XYyUIOJf2Ue4GE0+nbv7smPNrLFJAhN1zcRQW18v3dVj6n75jTSufHh6lrE5qMBI0m
         frAZJTsxkXcwkxmHikWCI/Vk2gLnGRkUDGdYAi2XESpXjqiXnKVZKHZesEl8SQXb+ba+
         tQTbTDSFoK+4zFmNgiPJH8O0CnXMK3QslHqiFTbYQ8jH3+s81z7aNmzNMs0odPFabYkh
         8cGV/f/ndcKTkpsLsM9NeQoVgAlhWNA73dRLU//1O5TCF/PogN2aepr7wtLeQ01UgCiT
         exwOdzqD27pN7NsovHgZ+O/TDBJ9zLU7Pl05nSJ+lUUSs9nG6/rKM4SERq90hf3A8mnX
         lbkw==
X-Gm-Message-State: AC+VfDwd0PejmRFIaTGLyagEWQGFh5c5YKbS1ke3dlWEzXxuzXG/IZNh
        j9Rf8aGQQFBKVbYlALVaH/2tQA==
X-Google-Smtp-Source: ACHHUZ6fh4mln5pueUK+qoRPhTaeDwiikEpVkQqwS0rtLgF0Zfs3eVhYT2bLEsjbijyGYAUEYQjE4w==
X-Received: by 2002:a54:4187:0:b0:38d:ea6c:66a1 with SMTP id 7-20020a544187000000b0038dea6c66a1mr283720oiy.35.1683584668998;
        Mon, 08 May 2023 15:24:28 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id p186-20020acabfc3000000b0039235300211sm516948oif.24.2023.05.08.15.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:24:28 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 8 May 2023 17:24:26 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc1 review
Message-ID: <ZFl2mkJPTOoz3TgU@fedora64.linuxtx.org>
References: <20230508094432.603705160@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 11:37:15AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
