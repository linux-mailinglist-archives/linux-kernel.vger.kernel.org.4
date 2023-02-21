Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919D369E76C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjBUSYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBUSYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:24:33 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C0CCDFA;
        Tue, 21 Feb 2023 10:24:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id da10so22134680edb.3;
        Tue, 21 Feb 2023 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XicgGxxpxnjWOAupqddiOjOjwVHxq+BPEsx44HPQNeA=;
        b=QTWnOKsaUPUp0dN+ok26p/p57wnxvJ9zQNA6WvOCq+B/Uapg2fsAXqfhwhl7w3rLke
         rRrjl5DSzfrxFyW17QzrpY76Zu8pfQmHuMNkIvA8D646a44f/0fxPAlFZ8Iott9td/W0
         z9mTNzn3g2QsUvMJKgAxhanOriMDvvbQojevqwKFjC/OI2XzqMdu4OKwRzwi6uskvdBT
         h8sYPbKs4yAwPO2lMlWajxaw87LYxJYlHMSJ41nMDLCMNSYziBpaDc4pA5/CXPLdCbRv
         fxQ+uRGTlPVKiW3hs8F7GAwcFK0cbOvR/KFCoWFpPLooZdfwgNPJTa++FKuva+RJnaHX
         bunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XicgGxxpxnjWOAupqddiOjOjwVHxq+BPEsx44HPQNeA=;
        b=Vepd8bSi8ahSW5n5p5PXu/52m/iC+E19F7FxHI1/ibwppdjMTiIDCqnz5wd2QPl8aQ
         hpYcaLu4a3g0QhYIvCEoosv25oRhKrrCkZhjIQG94R8zuLR3o/e6fX1mRI5d89XCrjQk
         vvDnZMCmAQ/FQIoAN6iNOLgDIJsRNdVh8TEELV8XLE19bjxfZuYjwODaD9nfxzlqnqK1
         qMU6p4Aly7lhikhjMbgKV2zOQwgfhj6aaCv4qe2DAONFaFRZkrRqOWaepJLze7kZn/PN
         oxt/XqaAB1Fn3yfkNVx/ag9Jtn+T7gJJcqsAn66KIQO6fobW+kuwuiQOlK80Va48S546
         xESg==
X-Gm-Message-State: AO0yUKVcMf0MxYzJtrEj4I5uFTQpCDHhL7JGJvi4YAtg1YgIz+TT7yLM
        c8gNJWYvdbyMo40t+uZ1nfM=
X-Google-Smtp-Source: AK7set9eFaA2C9JxaxHcQzx5t2aKoqYrMobeqSCJao7DFH76N6d16pI6tn+/FVWlT/bRyhwL+KxCKw==
X-Received: by 2002:a17:907:1dd9:b0:89e:8c3d:bb87 with SMTP id og25-20020a1709071dd900b0089e8c3dbb87mr14788646ejc.71.1677003870083;
        Tue, 21 Feb 2023 10:24:30 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id kw24-20020a170907771800b008cd1f773754sm3500642ejc.5.2023.02.21.10.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:24:29 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mcgrof@kernel.org, Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 12/24] kbuild,
 soc: sunxi: sram: remove MODULE_LICENSE in non-modules
Date:   Tue, 21 Feb 2023 19:24:28 +0100
Message-ID: <4779930.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20230217141059.392471-13-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
 <20230217141059.392471-13-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 17. februar 2023 ob 15:10:47 CET je Nick Alcock napisal(a):
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




