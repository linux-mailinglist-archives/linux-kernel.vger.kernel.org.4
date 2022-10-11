Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3278D5FB9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJKRqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKRql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:46:41 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4C025C48
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:46:41 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-131ea99262dso16774367fac.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8DRWHU9Bz1GMVQrvkwum1bjvouyHw2n5bA5321+xnQA=;
        b=gyNNoVMiPjJONib58njB5cTSF7Gq7C1pF3sql5dNIUiOBBjOAB+oQ60YlNAnGyZ4jE
         lfq0lepLIaT6OndQq2DqpgKrkC+YcrQbOiiFFBq+o6sdTXcLxb5attBotO7YOp85ay6R
         j3pKJAjccWT03kdE5lE8tAlITOo8+JCIKwOJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DRWHU9Bz1GMVQrvkwum1bjvouyHw2n5bA5321+xnQA=;
        b=nC7tQf1+E00lmwbfuzpwDqAuWUAcI6JVI7qrD7i6VCKyqpJTJAKUZ5wyKyF3KPaX0T
         yKEixHSxv6VtgoYhpFhOV2bMCrxv5RjdEs2hdcl2W7w/OZ5o0QB8ObBgjOSrQAkAFXXX
         QQ3nD/6qv7bZLI+CcxKSb0AMX9m8XCYzJDq+nzawhUnVJB1unx7d5Mr4kzw26qpi8Ika
         jy0JrXwboz+mpBAy84u5d08e3FE2hKovFf/Jmd6kAKcqwD0CNPmt74xvukF4Ah3bvm3l
         RSSj0xIrj/97/6C3TBv2+gmjvCnYH27cvAS521UfeXfWPT3oPEvNMHC9hVlOxpCI0YKU
         Z/iw==
X-Gm-Message-State: ACrzQf0+mzD/GADh8p/GHCAhyY6bpPF1bWoSHNsj9sV+FQ+E+wbMkr45
        VdTOAAKEhDpXLaGlja2scIZkk44vtdbADw==
X-Google-Smtp-Source: AMsMyM5MwAZ85TkkBuDPlhackUVu3KqSCYZwaTHah2MIpg+qGb8oa+OmtdoM8BWT070NoSuq/DzONQ==
X-Received: by 2002:a05:6870:f112:b0:131:f181:2c60 with SMTP id k18-20020a056870f11200b00131f1812c60mr188153oac.164.1665510398956;
        Tue, 11 Oct 2022 10:46:38 -0700 (PDT)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id d11-20020a9d5e0b000000b0061d31170573sm6492420oti.20.2022.10.11.10.46.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 10:46:37 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id h1-20020a4aa741000000b004756c611188so10575694oom.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:46:37 -0700 (PDT)
X-Received: by 2002:a9d:7745:0:b0:661:a3c9:3cff with SMTP id
 t5-20020a9d7745000000b00661a3c93cffmr4065627otl.176.1665510397343; Tue, 11
 Oct 2022 10:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221010175241.06ad4168@endymion.delvare>
In-Reply-To: <20221010175241.06ad4168@endymion.delvare>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2022 10:46:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjG6qk4VmoUpiKc1KoLbmEwehPAx6n-6MN7n+qSRYHzGw@mail.gmail.com>
Message-ID: <CAHk-=wjG6qk4VmoUpiKc1KoLbmEwehPAx6n-6MN7n+qSRYHzGw@mail.gmail.com>
Subject: Re: [GIT PULL] dmi update for v6.1
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
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

On Mon, Oct 10, 2022 at 8:52 AM Jean Delvare <jdelvare@suse.de> wrote:
>
> Please pull dmi subsystem updates for Linux v6.1 from:

This is so far the only non-tag I've pulled this merge window.

It would be really nice to have absolutely everybody send signed tags one day..

Hint, hint,
            Linus
