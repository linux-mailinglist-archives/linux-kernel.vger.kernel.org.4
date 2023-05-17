Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F804707688
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjEQXmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEQXmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:42:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20149E8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:42:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae557aaf1dso10939655ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684366939; x=1686958939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+PtovZvYqYzb6rdBWxcjpXWIgQA2DVctfW2duNZpLU=;
        b=QBIL4Gf66xC10MSiEmh/Y4/q+KGXN+g/irHWvDJkTkhDXGyl+AqoRywOth7u5X70A5
         I0meNKmbC6dcrd9TCXaQHUvei/hP1hjW1EDsMBWjo1Zjh1GLzRpBGMI3ytV/qsG83S4V
         rI+RW0v7vVKGMEfP06f6Q7U4WcJUj+AA4kiMTNVPfS6WM6e+qoQo+evXBvOGptcRPgpB
         ZknVgpst9Yvy8VFsJdB8s6QNfYDTOHQNwMolKhp4Q40CpS44SF2sHhj8mL1KZzp+3Jol
         Rc3nQ7C2S+L2TIgZeNYOQaTw7XD3hnFbER/nNdBgHFROyxjgbWYWpnGbRABCLH7KqAOo
         KmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684366939; x=1686958939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+PtovZvYqYzb6rdBWxcjpXWIgQA2DVctfW2duNZpLU=;
        b=dW1qG3CgnWSuXsHzKSm+DnNfVoGQ+nv0f+jsseQJCnUR8UPox103PVV5MoCYbYvxfb
         Jkdihv1KKvxCyx9zUVBamWAa8G84cO8m9WJ50eD57imTQLH3y0AKBEezr+2YC5kuSVXy
         vbvfsRC/kTCFNLVRhHriLo1LHf2NifeNTwbni6JDukFfsqbbXtl+S+altgBPNgZmoyXQ
         3p9OJvK7El9SK+5Xb/cMFgzh74U/U5kn/qnWMrTlRrabM8USqzxdvNeyPgQ4liKrGvBf
         bBG0ajbc67BRixEuQVrQI8TGDh+6tWMIS2doQmLRDRW+nOlcjZ/xJbq1DX24lBFbw4Sa
         rOxQ==
X-Gm-Message-State: AC+VfDyhmT50Q504q7b/ZOsHR/CbCKHO/Vz9lViuKGKhkLhrhLMtRsXW
        jgMU6CZrVIOWr5AcoccR0cg=
X-Google-Smtp-Source: ACHHUZ4if+bS6cRA7xGN6UZkvohloZYh/vkcXS7IWJhQFkuA1C25/lc3mdgoLXr6uU8qmCMsbhvjKQ==
X-Received: by 2002:a17:903:2606:b0:1ac:727b:3a60 with SMTP id jd6-20020a170903260600b001ac727b3a60mr574456plb.4.1684366939443;
        Wed, 17 May 2023 16:42:19 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902900900b001a2104d706fsm1059809plp.225.2023.05.17.16.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 16:42:19 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, minhuadotchen@gmail.com,
        perex@perex.cz, peter.ujfalusi@gmail.com, tiwai@suse.com
Subject: Re: [PATCH] ALSA: ti: Use pcm_for_each_format() macro for PCM format iteration
Date:   Thu, 18 May 2023 07:42:15 +0800
Message-Id: <20230517234215.3520-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZGTltcv6hSlJWLnh@finisterre.sirena.org.uk>
References: <ZGTltcv6hSlJWLnh@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

>On Wed, May 17, 2023 at 09:01:22PM +0800, Min-Hua Chen wrote:
>> Use pcm_for_each_format for the PCM format iteration and fix the
>> following sparse warnings.
>
>Please submit patches using subject lines reflecting the style for the
>subsystem, this makes it easier for people to identify relevant patches.
>Look at what existing commits in the area you're changing are doing and
>make sure your subject lines visually resemble what they're doing.

Thanks for your comment. I think the subject should be changed to: 
"ASoC: ti: davinci-mcasp: Use pcm_for_each_format() macro".

>There's no need to resubmit to fix this alone.

thanks

cheers,
Min-Hua
