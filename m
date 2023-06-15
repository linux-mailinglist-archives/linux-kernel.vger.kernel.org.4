Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B11731D23
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbjFOPw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344625AbjFOPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:51:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75F52D62;
        Thu, 15 Jun 2023 08:51:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9a6c18e45so29190611cf.3;
        Thu, 15 Jun 2023 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686844302; x=1689436302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMGvWB7qCwXyh9/PQ2byrILGfVlfUusH1V7kl9TByMM=;
        b=l7teeq/+SSI4vWph9DLAfOWAPSg4c36ggM3OTZNBRZP4eE4OubPUf5I8cyGipuskGg
         CYVbgulGIW5YMVozWLJrykfqPpArwaunD+ts7x0L0yJG2nrxJOuMJqsXc0gDTwqSr8lW
         ewReCtuAdSCkv5x7pmpFn2VXNh1JlgvOwQ4Ur3s27S9wJIzRzofTddwxI3aA0JMUqV8g
         SAXAuQm3WwMXOIwNwkHZ4QPXbOi0VjglrvIA8nWfLNKvH7LJXOWvTyZrR2jbjFIOOFUj
         0i+Ubd++4hUDVz+xrpJLXPNJ+iEhOrYx8NAGanXrnAzeNReqL2vvcfWrl74FCK1p6/66
         zgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686844302; x=1689436302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMGvWB7qCwXyh9/PQ2byrILGfVlfUusH1V7kl9TByMM=;
        b=hMgX2rmdJ5OGxx+rXSsmM0ek60c3iUtpbuiON/DXNn6z9Bv4avYMe4yTPSlGg3lgBv
         oQyD/qOjz5jcGA1J2HQy05YupJmudknlsEPaO799cKoRgtd7U3cXkxW7K/NjoO+o/5hJ
         gjMkoeA1eEi8RRLOhT5eoNTFyYNQVumo+lOoUHQfg6IYSTQF2cpmAgXXfcOZ2ZAjQ0cg
         QhwEpA1rFpNXnnbjCh9As/uVoacrieVGcQV4jvc1d23kjzRvWOnYk3e1kgTA0J9cTHYm
         /a+RWea64NVtGKBz8fAikpXN5KrDBgB60xPeYUTUFPRPdctxnkS/1i2ja6cbIFRmQAXB
         sEJg==
X-Gm-Message-State: AC+VfDxGh2SvyxlWTeuscRrV3/e5GdSZ9yCiXU5r3aH0bAOAXK7K68DA
        NACzeslKdI+a16rlFI44y04=
X-Google-Smtp-Source: ACHHUZ6tU8hBu38Pe9mYmBNc9WTxS6G8pH9X+cVtXxbAmuoYZYMW6QNruSv1bP/81jJMeEu75qbQgg==
X-Received: by 2002:a05:6214:262d:b0:623:a5d0:1daf with SMTP id gv13-20020a056214262d00b00623a5d01dafmr22071446qvb.48.1686844301710;
        Thu, 15 Jun 2023 08:51:41 -0700 (PDT)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id z7-20020a0cda87000000b00626195bdbbdsm3147599qvj.132.2023.06.15.08.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 08:51:41 -0700 (PDT)
Date:   Thu, 15 Jun 2023 11:51:32 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: litex: add support for 64 bit stats
Message-ID: <ZIszhClhqSPeFfeQ@errol.ini.cmu.edu>
References: <20230614162035.300-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614162035.300-1-jszhang@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:20:35AM +0800, Jisheng Zhang wrote:
> Implement 64 bit per cpu stats to fix the overflow of netdev->stats
> on 32 bit platforms. To simplify the code, we use net core
> pcpu_sw_netstats infrastructure. One small drawback is some memory
> overhead because litex uses just one queue, but we allocate the
> counters per cpu.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---

Acked-by: Gabriel Somlo <gsomlo@gmail.com>
