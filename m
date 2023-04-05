Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6776D7D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbjDENKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbjDENJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:09:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1290D26B5;
        Wed,  5 Apr 2023 06:09:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-92fcb45a2cdso48069466b.0;
        Wed, 05 Apr 2023 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680700196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ABwXzX9ED7ffK8apt+kOqvZLK0zFOVMM8GUx+TO2Y4=;
        b=J947sK/H2QM6m2NIyuhMaGvEqeddONKCuWPFky5HdkFJytSPe7WZxywy6nxq3ueE1X
         fdbSVcHrIxbda+lelGerJs0xR4JHh/FF4I6T9Lcsiu2BgBiNTi8OItEtgOEK1LmbDVCv
         pqhtEg5kKRyPrqXkmfPXbYX4uKnhbdO5QroUoNElNunCpfA7OL2WFLItiJbYTwSnWcDL
         mJBSBx0nWZWrGflk2s5/Hi+tmHQsNnlJWtosryiz7lA7K9FcdRW/z7ZDCdYCdOVhKdci
         80OjPn7kVZS3NVJTfko5Vd8kKGJ1HR6dHJbEpNLwgNh/BRhLlu3J539g9IVzjuQpb5qJ
         yB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ABwXzX9ED7ffK8apt+kOqvZLK0zFOVMM8GUx+TO2Y4=;
        b=Gn65IviFXcDO9HTcjFHtc1FSa8uRNhP8k5Xbym50V7DftKpbsy0pv8r21/UZZ0wwEL
         qOZB1Efkbm9qSwgCkgpg100IzORxX4IzvrEImXfwdqNZxoeB/QEGMCFpIJYYzYoQlhmT
         XkbeECp1KMzvGSQoiXhND0vI7tOmGNMzKCvvkfKxTZH7qGA29/r778A29KcQZUw109wP
         BozJebu5lP5faeQ6XREKFGKBI3X5r5ppnt0CaoYLpAeQnidso4kJPZLBxHPbw3n7wZaE
         1xgYj+0zE2r7CY9WTXyCNwU6DZZxy9VLZ8RAG2RXEIxqTEbomhVdtKDC39B3KrZyyibN
         +4tA==
X-Gm-Message-State: AAQBX9f5adCGfSTfyG8mP4t/83HkHFsRH6s/vGVMvjZYVRUMDc6JTtWb
        hRgckNvewpUs6BCvRa8lSHc=
X-Google-Smtp-Source: AKy350ZFN+1S2Jl91B+pmFj3c+sgStbb2dBs2rJdrMduqKM475PkGVBM03ai3RZUq9ciRWyHdf73Wg==
X-Received: by 2002:a05:6402:148:b0:502:32ae:14fb with SMTP id s8-20020a056402014800b0050232ae14fbmr1754229edu.5.1680700196289;
        Wed, 05 Apr 2023 06:09:56 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d7-20020a50cd47000000b005027ecc148esm6807750edj.65.2023.04.05.06.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:09:55 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: Re: (subset) [PATCH 09/24] kbuild, ARM: tegra: remove MODULE_LICENSE in non-modules
Date:   Wed,  5 Apr 2023 15:09:49 +0200
Message-Id: <168070017411.4044223.15212068652607056465.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230217141059.392471-10-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com> <20230217141059.392471-10-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Fri, 17 Feb 2023 14:10:44 +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> [...]

Applied, thanks!

[09/24] kbuild, ARM: tegra: remove MODULE_LICENSE in non-modules
        (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
