Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2E263289B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKUPsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiKUPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:48:09 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD717640
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:47:31 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id b131so14040957yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lX4SOBDZLiUpWg9pkZno03V4C7f9ub9okjp/emDPZ5E=;
        b=plxUBELReUUHAMjKqZGq7NrMXoG6g+bgMnMomPSeCEe9NR6/w5tlNXzl1sR7MGUTUL
         ML0B5jLMeFPOKSnE7RTGTlPhVrnKXEbny2Oe6nFpASFq5sIm8muKVEUk2KvrOE3tMaHp
         OFsLNv8w2TjmeKpMJqThjQO2losarCoe9qsQFvub2T1dO/j5I6L5qnTauaCBR0GAUiWG
         a2DvU/4JTVqYtRPqX8wL/JK1GcxMHe8i7/25WcBIsxc1CDhanUHYuIoCqHPDX24ecxLX
         C6brYJlpjd4CRT5T1E9Uf/ad497t0h9+C8EPPlTSbROL8Lg80ilqEIqxFNTafSsJC0kk
         D1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lX4SOBDZLiUpWg9pkZno03V4C7f9ub9okjp/emDPZ5E=;
        b=ahrfwj7+l+dvzSuO4um/K/jobf33LHDc1vJ8Q1kBGNw0HJocd74rKrG0mtAWdqv960
         ImIsTFm4RwXsYL3k0MF7a9EhGJhkOoojrKXP65VhNTKOtzFY4M4m8zOM7aD5fPKBS2cf
         mcdJ+DU+FovA8I2hZOjoJMMmdnrcEmWmiSMbSr9HtfC0akPn/laVeL/clDNOeFMG3MlH
         8hQAqxrwB+IkM487rmSxXMiesZ37DfJ+sMv5hLZhpNVRMuGjPSTBbN3+bmQ7vt1YA44B
         LiePBARtaGzqG3M8/XF3tTkdTJl2qN5DdjDuLPOiFLw6HxjpxQyjG0HfYLLgV1n1aUwc
         +qbg==
X-Gm-Message-State: ANoB5pnJFj0NLHHZrhsXo7Kp9JW2lBQ17TIrKDDpo/4qDzWvMvlMBh3t
        wUncLz4YByYivS4+XO3dppI3BKaCb3Tnpg6bbABqnmC05ettxA==
X-Google-Smtp-Source: AA0mqf7maI6e3C/Uw3HIVqetlcmAXPqACFqV7KLGkeMVJp87hEs5USoBCXFyQhh//F/a20TiI8/RVccZQ+GyM9TeLAE=
X-Received: by 2002:a25:880e:0:b0:6e6:e31e:3dc5 with SMTP id
 c14-20020a25880e000000b006e6e31e3dc5mr7246672ybl.534.1669045649850; Mon, 21
 Nov 2022 07:47:29 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 21 Nov 2022 21:17:18 +0530
Message-ID: <CA+G9fYuYashEQsCfScoVbVqAxeXC4w6VnenO-5dHDH8OEfFBTQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKFT detected arm64 boot regression on today's Linux next-20221121 tag.
The Kernel boot log did not show anything on the serial console.

Anders bisected this problem and found the subject commit is the
first bad commit.

# first bad commit: [9ed2b4616d4e846ece2a04cb5007ce1d1bd9e3f3]
        arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)

Later it was found this lore link which was already reported [1].

ref:
[1] https://lore.kernel.org/all/Y3pS5fdZ3MdLZ00t@dev-arch.thelio-3990X/


--
Linaro LKFT
https://lkft.linaro.org
