Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3DD66C370
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjAPPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAPPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:17:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D4B741;
        Mon, 16 Jan 2023 07:09:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B186B80FC9;
        Mon, 16 Jan 2023 15:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69F6C433F0;
        Mon, 16 Jan 2023 15:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673881755;
        bh=bSC1tYJtE/dAJ69MMY56mA9Mu7Fri07NMWjxcUc/p34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EN08y2BuPRT6MOp7kivWfwKdujHpSZ4tV0oOQ0TZqkbEdlqbRtJSucfj+l/cT4ODO
         JKtdwLrgH1dcWjxtmAOjS+TPZ9kGfDYJebguFpTbE0aMf3WODEl+n+5An6CX+B8h1L
         mhU3oRL+bf+bY+IttnYqRMC62d7YNdqocYDRkVJqlw5gAbXHgudajnAFGJfVNjucTu
         T94cEKji9NpjfbFcsnKPRAz7zZ3/UFoSNL6QhLvKkIYGoP1bONypCSXYt4MyDH3dlj
         SKe1tPsDsJO2cx/Y0+UbiW5So+dvJy6BAgGi7A0JlQBTvdU60j46WfSLsRHFftY0N+
         lgoMg0d7C7dbw==
Received: by mail-lf1-f54.google.com with SMTP id x40so9061324lfu.12;
        Mon, 16 Jan 2023 07:09:15 -0800 (PST)
X-Gm-Message-State: AFqh2krkafaju4jAajuGdFBHHFrc+yZC2SiO99in2iRDwMx0yKPGVMqI
        TsNo+rk8gY9m1groTJfReU3136IanRKVINdbfMA=
X-Google-Smtp-Source: AMrXdXvh8R29wCMut1pV0svkKYDMsD9TH3JlT8/hB5GgbCWkus0sb+dZA7j5Fz9qVyrfm27DyrNT2oTIzQhQCET7cqs=
X-Received: by 2002:ac2:4f8c:0:b0:4d0:7b7:65dc with SMTP id
 z12-20020ac24f8c000000b004d007b765dcmr471882lfs.122.1673881753755; Mon, 16
 Jan 2023 07:09:13 -0800 (PST)
MIME-Version: 1.0
References: <IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca>
In-Reply-To: <IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 16 Jan 2023 16:09:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGjOF7bNCS-v02aTZWmzvM-Ad-VYiNbHEmYf5RMHL57bQ@mail.gmail.com>
Message-ID: <CAMj1kXGjOF7bNCS-v02aTZWmzvM-Ad-VYiNbHEmYf5RMHL57bQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86 - exit fpu context earlier in ECB/CBC macros
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 at 16:00, Peter Lafreniere <peter@n8pjl.ca> wrote:

Please don't send encrypted emails to the mailing list. Plaintext
only, with the patch in the message body (not as an attachment).
Please use git send-email if you have trouble configuring your email
client.
