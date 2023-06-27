Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED87405B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjF0VfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjF0Ve4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:34:56 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F92D7F;
        Tue, 27 Jun 2023 14:34:46 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b74791c948so2619277a34.3;
        Tue, 27 Jun 2023 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687901685; x=1690493685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoNIkdlIM68z5SetPdRPA7///fyuGudIF7ZaSXzBhYM=;
        b=dcEN+fI86VBdAR0QHrg3+bEaX+Z4GeThNqqS4tP+iMKAMlqNRVLfM9Ng3dFwz/41BD
         DXVfP9vsSX7EPWGp/Jel+s510eBGtrU2G+vNRHiJwl8A1i2trlsyc9yBoRz52OCV9CUn
         G2hPCd0sLeEahC4shorBtaCtQdr2EIxO5hPuEEvVA38iG0Rn5po10aaveozb15Zr8fZQ
         bcmhPzxpGpK2+4oh0dUiI/YD/8gVyytT/f98zQmiJrfZIpFq/Mi9kIYun0xajlcyjrVc
         3hKvuHORwxqvRCZwJ1r0qN6fJNYN8jhI8EUA+UPvJYPWfl+i8ivyWT+koTtinLzBR+G3
         iFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901685; x=1690493685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoNIkdlIM68z5SetPdRPA7///fyuGudIF7ZaSXzBhYM=;
        b=JyePobI10yOmFfjXyc+qDUhceeGAGdA6UitbO5n2mzngiFso+/LpIHacXBRybDMO/M
         c+7uOKhD1c9WGmAUCrHH359mvJ0iUA3vPAVUTef9h/DRnCDbEjHhGgYQ4qeFsNl7U6CI
         yKUVyMPCUzYwFRP711u3h1/KL9G/02USWarH/ox1VVG48Fkh4dUrg+sVwcI1sdTHrYwS
         dOUiWHkhfdZhwV6doECToaLN3zExXSBTFoeZh6cB9qguKRKeoHMeObPmur0MC+CRE6fg
         ok3QiqAKGBpBl3ovF2k9V6ltkUtP0VehP3PE3ThI8Fnfpmr+u+cz2iJh4vTSRW7sC0UC
         hPHA==
X-Gm-Message-State: AC+VfDz7W+2SSAUyOkpgB8rv6L2qOFASgABdmGqa1aAAJZmbGdhLO5PI
        5+InBTGtIj7AOOSxkP7uHPs=
X-Google-Smtp-Source: ACHHUZ5w+b9NgKl3jYcpgPwltg5qsZDlTcEatjyr7WUFzMb4VT6gWtInaoVHHZ/14rQHD/ai7hXEnQ==
X-Received: by 2002:a9d:6343:0:b0:6b1:d368:557c with SMTP id y3-20020a9d6343000000b006b1d368557cmr30900092otk.30.1687901685457;
        Tue, 27 Jun 2023 14:34:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 38-20020a631166000000b0053fb1fbd3f2sm6123749pgr.91.2023.06.27.14.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:34:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Jun 2023 14:34:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 00/41] 4.19.288-rc1 review
Message-ID: <effdb8fc-0796-456c-b93c-3968278ee442@roeck-us.net>
References: <20230626180736.243379844@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:11:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.288 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
