Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304BF710095
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbjEXWD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXWD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:03:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111C10B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:03:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af2e908163so17943031fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684965804; x=1687557804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGJNYAB8T/lr+YL5tSEXLDHHn2s+eih/Ya1hsZucDVU=;
        b=YGnq6z+6UdWriHJovvH32ejeIEdFSsUsF0YwCxsLX4Eaj2Mn7bQfdQ240fsbxanWfx
         eSodL/Nfer1LbYRRoDsr7hr8HNFON59XtBDlNUiJBYgB1wf5lz58i466bC8N1WBde64j
         wnL1YisuMgB17ECW/zH39qJdHs/r7jZIaHHfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965804; x=1687557804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGJNYAB8T/lr+YL5tSEXLDHHn2s+eih/Ya1hsZucDVU=;
        b=Sw9dAdfD7QFgP7CW0Fe6fwW/PniTAPizqWz4+ORpo6g8u3FGuYF3w3epAIYAEyGZRD
         nAieE7PVL56xdoSKDr8k9y2LGvis5jzNbrCT6D01HcXDEQ6H9oHlZtxEF0G1b1QCExF9
         Zw0dEtEqbVEjaxw5TpUxAhdR8sEVN98sHLO+yU2HCjOG7hjqSAPbGWeG9dcAUSoLULEf
         gUmbma8dcNn3b7kQ5VJsCMuk3vZ6tmTT02/cz/eSV/39WpcNGP7Mb4/AnKfJOOytjQ94
         l2FeIchnizJrac6hrbV8YwbDsfcWugSqeg6rFNP6AAzUR0U+RjKE5rMc7lfYZAAd7AiS
         1PrQ==
X-Gm-Message-State: AC+VfDxDBsb8b0mKLiMa5SWqBZv6J3+ywvCakK+cxEh+2WTrQIeV/hDf
        PK8P4pdltvFTVwqCzuVeM/T0Ekzzlt/FQcUdJOdaymqC
X-Google-Smtp-Source: ACHHUZ5u/Gpa6gWeoJQI/LEUyhnGpSIRjPk82ZKYg2KA5r0NgDfftGEGnUvoe20Hv8oH9O7bVYoU5Q==
X-Received: by 2002:a2e:9001:0:b0:2b0:3046:9c6 with SMTP id h1-20020a2e9001000000b002b0304609c6mr332038ljg.9.1684965804376;
        Wed, 24 May 2023 15:03:24 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y14-20020a2eb00e000000b002af0464353bsm2177846ljk.106.2023.05.24.15.03.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 15:03:24 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso1509101e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:03:23 -0700 (PDT)
X-Received: by 2002:a17:907:268c:b0:96f:65db:d6d2 with SMTP id
 bn12-20020a170907268c00b0096f65dbd6d2mr16749757ejc.14.1684965423649; Wed, 24
 May 2023 14:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 May 2023 14:56:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9oPrxcMK469X0zAueKQ4tqX80SdFqCx9StcL82vuEkw@mail.gmail.com>
Message-ID: <CAHk-=wi9oPrxcMK469X0zAueKQ4tqX80SdFqCx9StcL82vuEkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate detection
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, tglx@linutronix.de, hch@lst.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 2:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Stop adding horrific code for some made-up load that isn't real.

Even if you trigger some "worst case 3x memory use", that is
_temporary_, and will be free'd in the end.

The patches to "fix" this are worse than the disease.

                  Linus
