Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45585F58AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJEQ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJEQ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:58:14 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F116762A95
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:58:12 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1321a1e94b3so14800257fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lnsBPDEZubxRfuIEKW+Qm+2YhNTMpFnRkd4ny9S+yOI=;
        b=CgnGaq7Iwrc2G64x0rL8shaC+ThbvRwqaADWktFx7d5D+Yo+ZVUzON7ywjBprFi71N
         eLmm3nuJQfn/rCGynd1cc4bcCwfMrNroIhX0JKni23OnTrcT519DncHOozZi/F6YdpJK
         XsxwDk8KiY9oFPSrDRXEGRRv+9KlnEu0Mdisc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnsBPDEZubxRfuIEKW+Qm+2YhNTMpFnRkd4ny9S+yOI=;
        b=vKI5iuQTb9y1qaxHGm8iIB4KVZ1BKUhydUMkj9VJqDhnyI9NaLpQkC2RM8e+NDYl3V
         Ify6j4+RKMimlyFGrRKkO6OKWLxLqoUszbq0eoNoyEXBKhK7xKTcKxo350Pa67V41cUf
         i2C1Ne55cTLmiK33e/8jdjUFK3XTdvwsMwsSJAh1hrwGmoxrff4Y+aKVxrrfMZAPT2li
         2K4Ln5EKQwXfvD3oc7uNsqdwvCLY0zLw9+UMbwPYxAKM2xKcX17lPLXpwsYS08dm1NsG
         9nInk9pKdrSLzkUClTRlodMgpBs7LniZDPQKvX6DcDc20jLvF9o5j4yWhz8P07fpZiGe
         zCzA==
X-Gm-Message-State: ACrzQf1kwbgEHeszLDxw5LQ0Nb5qVdKboMl/Y6eyqHCZIb82paEBBv2Q
        UMivnljnxSjSyf+IUyldnNqyAtjSlt7iHw==
X-Google-Smtp-Source: AMsMyM6VgzaVYGdgJFRFuB9W15N8xUVMp/ZSgHR/1MgUySCfHTsw2WqJkpE591DxRO0H4dffKbH5FQ==
X-Received: by 2002:a05:6870:6086:b0:132:e9d6:ea36 with SMTP id t6-20020a056870608600b00132e9d6ea36mr1195001oae.116.1664989091391;
        Wed, 05 Oct 2022 09:58:11 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id s15-20020a4ac80f000000b0047f72b6988fsm971688ooq.45.2022.10.05.09.58.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:58:10 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so11210678oon.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:58:10 -0700 (PDT)
X-Received: by 2002:a05:6820:1992:b0:475:c2c0:3f92 with SMTP id
 bp18-20020a056820199200b00475c2c03f92mr163826oob.96.1664989090222; Wed, 05
 Oct 2022 09:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <YzrF7i/lva5JRpxK@owl.dominikbrodowski.net>
In-Reply-To: <YzrF7i/lva5JRpxK@owl.dominikbrodowski.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Oct 2022 09:57:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whr+1YKT+VeqYkq=4kZxNOkhCf+1SOzNbHAXTG=ZBfBDQ@mail.gmail.com>
Message-ID: <CAHk-=whr+1YKT+VeqYkq=4kZxNOkhCf+1SOzNbHAXTG=ZBfBDQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCMCIA odd cleanups and fixes for v6.1
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org
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

On Mon, Oct 3, 2022 at 4:23 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> In contrast to the last pull request, this one employs a signed tag;
> hopefully with everything in order.

All looks good, thanks.

                 Linus
