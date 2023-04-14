Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6FF6E2129
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDNKnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDNKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:43:05 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C7E63
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:43:04 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id p133so1946542oih.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681468984; x=1684060984;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lReA+ncD6yIgYbMrwcUzGWmHYZNQhQliejFF65m3oKY=;
        b=kiMmTgpoZI+4Sb+Hv4F1q+c77rAB00BcDrksRiQ58LDA84xWqIs/QuwIDIAdMYDNjW
         BRFH/kNcZ8s5a6CQIHA0WFy+7n1+ooBkLf578mvlMdyObVUUyzgO3IxK1SFB8gu9Z5M/
         qRLmiUKYrAWxp3By8I37RPo+BJmWNG1GQQd3X/y3eBWli2ieKVwt4SylRhAXQQCwF88/
         YXg0XRG4pPGxXXh6P0fZ+KdewaI5ivVebg2acd+CzI74fBQHYPnRg76uoPeHk/5J8O4Z
         TwFTM15nFvSefAJpk2UT3hkkbIFcZCL2JClghOhzHsOSGEnU93CWjoDFQVkHb98EY0tz
         OTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468984; x=1684060984;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lReA+ncD6yIgYbMrwcUzGWmHYZNQhQliejFF65m3oKY=;
        b=jTGIZ4GiL3fp4/y5wZsp14tJ6mC/jpe3W22wNMJYi9kLoCsfDi4Sta620VOhhBVGfS
         x1NvLP1GdXobLuSRfZjHKeLKGYLImxkV3SxfI3FrMpPq29N/i/j0S8KHLyJqc8GKhhV3
         D+S+N/mKVuPyUQe+Qv1iFBZaNI6QubEl6USpFsGDsiYXU9in3p3+I4n1iNzECIE3B/Ln
         aQ1tSuwqP/7iePGMJet4HNNxMGV2gOTEQvZHj2ypwghsRr8H/UpJZB+OuZlVH+kIfVCk
         h6pWIOozP03o6YUOQtL/YnMrZ4phVmjjHE8Ra778S8Urku2ceuauGc6BDFj+/+AvyPF5
         3YOg==
X-Gm-Message-State: AAQBX9feboqKbPV4K8JJIPKf61BITE7ydzcqj5ad6KrjYy59IXzQcSgI
        +iywaWJOjRpXqpbZWsSyTkmIjSpyuEOHB6SeXNefLWNSC9axgA==
X-Google-Smtp-Source: AKy350ZU9zDfhLK7ppiiviRe0MJUGmPgMXi7E6cwhLFwIsLGDHFQAzmkvYp6SSz/C7nBdB/AbYFwl6Xrj97OVx8N5uc=
X-Received: by 2002:a1f:a154:0:b0:43b:6f57:4a00 with SMTP id
 k81-20020a1fa154000000b0043b6f574a00mr2788371vke.3.1681468607096; Fri, 14 Apr
 2023 03:36:47 -0700 (PDT)
MIME-Version: 1.0
From:   No Name <xbjfk.github@gmail.com>
Date:   Fri, 14 Apr 2023 22:36:35 +1200
Message-ID: <CALS7K9V1j6ufrQ=6nGjyHQCWb7-YiqNdctBWk8og1gW_q4C4dA@mail.gmail.com>
Subject: LLVM not detected in bpfutil due to LLVM 16 requiring c++17
To:     linux-kernel@vger.kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first time reporting a bug, so apologies if I get something wrong.
In tools/build/feature/Makefile, line 342, the c++ std is set to
gnu++14, whereas LLVM 16 now requires c++17 to include the headers.
This results in the llvm feature being falsely disabled for bpfutil.
Perhaps the --cxxflags, --ldflags and --libs options of llvm-config
should instead?

Reagan.
