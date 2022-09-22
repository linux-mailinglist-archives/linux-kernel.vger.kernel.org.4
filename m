Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FBC5E6A78
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiIVSOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIVSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:13:59 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B651F6F72
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:13:58 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1278a61bd57so15052199fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dkVRxV4I7PRv0MPIkVzG//6n2SRR1vW4Iw6tfZvXO/Q=;
        b=FBOenVp5aH9X3CrUtLiquxr3kaSJbtIVoLUYfQ7rl6ER/kZflhaBvE6UcKAv/XzAKq
         +4V1KeJ4aRW0ixoTj0+nNnoM1P5NTQuQC74SGgKlbtCWcoHapIFa//0vox5YbieVbBH4
         j8Iqb5tNaEkW6g/9EhujwNlLr7pCOcOim5/NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dkVRxV4I7PRv0MPIkVzG//6n2SRR1vW4Iw6tfZvXO/Q=;
        b=see9fFmgzX9Q+/FbaQY8ugBmM2Ue2BcXKmetwRsOc6FBNW7dOqLJ++poIQ0sRMV/cl
         7OQIy5BWcddXnb/slqjm+hLqoO6PaQLxUF5Acjjf+gYVyDdh8rC6fqhhJmOmYppvGtAc
         B5V3LuuSg0p6MZGyXrbwsMVdPEN0ZjybUCFku2BhmgotdUj3V8silnUH7eEXlnQjpyjV
         JNFw5T4NY8sL1RJu2mzukaoNmh/cB83aTwjHx7YfAs5dZrpJzKs/7w+jU2aejrklF5sb
         TvtdByRbPgn5Sew2gsPBj/hqcKc90vprGIgqB5yqsgpBwqYwYxn2h1XhMtxq11LbdegU
         BAtQ==
X-Gm-Message-State: ACrzQf3c+WVuMAQDHJeiz/Elz8GmghtWWfcZvKsyqk/u22ElDErYAqvZ
        iwqc8tRedN2bFL3wyg46XbUz6HZDslSHIA==
X-Google-Smtp-Source: AMsMyM4yrUOnaFaedCOFCZN/MaNXP7gqxdnKuDpBZ55gPq/+/Bsne/9yVda/iQg2LQUG1NtJ1mIOpg==
X-Received: by 2002:a05:6870:e615:b0:12d:943e:256a with SMTP id q21-20020a056870e61500b0012d943e256amr5124606oag.83.1663870437228;
        Thu, 22 Sep 2022 11:13:57 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id cd8-20020a056830620800b00639443424f8sm3110909otb.8.2022.09.22.11.13.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:13:56 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id o184so13356161oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:13:55 -0700 (PDT)
X-Received: by 2002:a05:6808:2012:b0:34f:ca73:ee55 with SMTP id
 q18-20020a056808201200b0034fca73ee55mr2388937oiw.229.1663870435647; Thu, 22
 Sep 2022 11:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <acdecda4-b11a-4e15-9ac9-6d2696218012@www.fastmail.com> <87427dd0-7307-57b2-4008-2ffb839a099a@gmail.com>
In-Reply-To: <87427dd0-7307-57b2-4008-2ffb839a099a@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Sep 2022 11:13:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiux9J6zi8sEHyLBVYc7zsWe6JwYOf7ggF+Oowc6fp4tQ@mail.gmail.com>
Message-ID: <CAHk-=wiux9J6zi8sEHyLBVYc7zsWe6JwYOf7ggF+Oowc6fp4tQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for 6.0-rc6
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, Sep 22, 2022 at 10:19 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> In case Linus has not had a chance to pull it just yet, could you amend
> it?

I did see this email, but as I expect to be AFK for the next few
hours, I took Arnd's pull request as-is.

I could pull your Broadcom fixes directly on top if you/Arnd would
prefer that as a solution?

              Linus
