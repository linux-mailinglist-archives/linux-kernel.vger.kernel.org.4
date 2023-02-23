Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913856A0EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBWRWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBWRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:22:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4004ECC7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:21:57 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id da10so46041563edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TBR1Hpao5NaMspTRHD1lsqDclj6PdB0M/zqkOByY88Y=;
        b=aGXtyooH2QtMysuzpHxM6wkLHNoBaCSVaRsdZy4hnHNUXZg6GQAsg6EXKis5mK8mD3
         4y3LsMsCun10BudugEuxQZLLsHA44JVXf1yHYdurnnNxvFqw1jYKiqt3kg1ctAxSrjL9
         eR5ARjHglQBu+lzI9Zhs3UvX1muEo3kUQKg50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBR1Hpao5NaMspTRHD1lsqDclj6PdB0M/zqkOByY88Y=;
        b=xm6mD8CDjfCn9s1D6jyAWOLQi4kGRaHNKLxbn9OJfY5MaDHlh5aKbB74W09SCF0M6t
         NApWlpFZbSoCms77hYfKd8JxO57i+e0V5sxGDL+fnYFHQg3sixgI9Z41ZQG/5YxINQ0e
         ZwPUhWNp0FibASkB8zXbz2tdKR1Z21Hjr75hfW7cA3gVj5ZyycYzREfVyeqzFLMfV43K
         Vvo/OMjttzEDoBQWAnnRuzlOi/v93OBglZdAJ/4Ln8pKHRkwyq9qjYYCmhz4Kplp5arc
         u+hWpcXOx0bKFR2aJEWSgpgrVWjPR3tJ+Y/vfbQkLRVhOIVS9c39b7iyF5lwAkHV9w20
         TwOQ==
X-Gm-Message-State: AO0yUKXhoVOt7wsR3cxA5+i0QD4DaYG/g6AMlNMX6im/O5ZeQCvg5lQ0
        ZRXaedCcz9FP3qef7S5wU9uMkRNkqTlnJIaa2MwOkw==
X-Google-Smtp-Source: AK7set/Sy5kgPTx0YKAb1dqeb/XxNgc11Niam7GbZ/zUagdVPjdCZ6KsCgLTJV/il3N3pFVt+CSXlw==
X-Received: by 2002:a17:907:2d29:b0:8e6:bcb6:469e with SMTP id gs41-20020a1709072d2900b008e6bcb6469emr9691756ejc.0.1677172916033;
        Thu, 23 Feb 2023 09:21:56 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id gs23-20020a170906f19700b008ba326ebaffsm7646579ejb.191.2023.02.23.09.21.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 09:21:55 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id ck15so46061581edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:21:55 -0800 (PST)
X-Received: by 2002:a17:907:988c:b0:877:747e:f076 with SMTP id
 ja12-20020a170907988c00b00877747ef076mr9185882ejc.0.1677172915084; Thu, 23
 Feb 2023 09:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20230221233808.1565509-1-kuba@kernel.org>
In-Reply-To: <20230221233808.1565509-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2023 09:21:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTMgB0=PQt8synf1MRTfetVXAWWLOibnMKvv1ETn_1uw@mail.gmail.com>
Message-ID: <CAHk-=wjTMgB0=PQt8synf1MRTfetVXAWWLOibnMKvv1ETn_1uw@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.3
To:     Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 3:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
--
> Networking changes for 6.3.

Hmm. I just noticed another issue on my laptop: I get an absolute *flood* of

  warning: 'ThreadPoolForeg' uses wireless extensions that are
deprecated for modern drivers: use nl80211

introduced in commit dc09766c755c ("wifi: wireless: warn on most
wireless extension usage").

This is on my xps13 with Atheros QCA6174 wireless ("Killer 1435
Wireless-AC", PCI ID 168c:003e, subsystem 1a56:143a).

And yes, it uses 'pr_warn_ratelimited()', but the ratelimiting is a
joke. That means that I "only" get five warnings a second, and then it
pauses for a minute or two until it does it again.

So that warning needs to go away - it flushed the whole kernel printk
buffer in no time.

                  Linus
