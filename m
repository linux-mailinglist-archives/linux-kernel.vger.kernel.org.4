Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B856A74419F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjF3RwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF3RwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:52:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81837358A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:52:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51d804c7d14so2200634a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688147538; x=1690739538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2vWk36yLkPExxtTUYLB3jB9HM0N2/RvdMrjjxiVUFf4=;
        b=fPV1x4v8/CuiUAEQenTlV4KJe+s8uPDwCluSPoznpN3uMKJHcvwlFtWolenl6QuYpQ
         XSxuxpHv1TjfA/3fNR7fFyPGRTDcMTVi9bb+AU0ZvyltLXVLsdHedPEhvBMUUirbzDFl
         wiWuYYpGjnD6KEUc7IgTNXhT0K8Ngy4cEfP58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688147538; x=1690739538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vWk36yLkPExxtTUYLB3jB9HM0N2/RvdMrjjxiVUFf4=;
        b=ZcQkWhGfC4DmFZxC+wdNIfKF+eWNKDME6NciE+NxgbyJ4oGcory2jqaDYrIuTTnXLq
         64GEIHcTMH2ehGaR7+XhoxN/sD4tZMckwkP5F6/14o1B091bjPE47dL+G2jkNZPQIIir
         sj3BASNtx7rqzNal9scaKDbzMn6ft/AO4wYxpLe0Ul26aUPyHd4ooum8UptFI6HGO9di
         4yRUzOkn/nFJdBewrDfR8LfCj8oiDUUqrkMHtIQQJIkNsHzZoF12fn4FencydxiVDEzT
         zUiGBA2iCq+218nM6LjtlKSIUMC9HO98EgE/yPTwys1xQ7bA6xLv4yLC1z1y5XxFR7+0
         iFSQ==
X-Gm-Message-State: ABy/qLZo4LaZLOvwPh53dKnaAPWrS1iy5s2bf0W2ACwkQXdzfu9ESMIG
        0z99OwVVHVb0Fh2SEe7G40Rl0EQSoLSrNVRrNLQ9m+Ns
X-Google-Smtp-Source: APBJJlFSyCP9fUU4YeRMDLB/Deq76l3w2MMS9EOqBF7wUMzHw3T7+Jxmg/+0x/+ErlDIw2vT6EAfbA==
X-Received: by 2002:aa7:c3c5:0:b0:51d:914a:9f43 with SMTP id l5-20020aa7c3c5000000b0051d914a9f43mr2078805edr.36.1688147537857;
        Fri, 30 Jun 2023 10:52:17 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7c64f000000b0051de52f8adesm1394196edr.32.2023.06.30.10.52.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 10:52:17 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d9bf5411aso2202851a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:52:17 -0700 (PDT)
X-Received: by 2002:aa7:d5cf:0:b0:51d:9f71:23e2 with SMTP id
 d15-20020aa7d5cf000000b0051d9f7123e2mr2121236eds.21.1688147536741; Fri, 30
 Jun 2023 10:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230629101316.d8eff69f9899f6c895ac64f5@kernel.org>
In-Reply-To: <20230629101316.d8eff69f9899f6c895ac64f5@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 10:51:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghSiMXEaWq6MA6C8ye8-Wek7WmnkWYpCNwv=N8R+rQgg@mail.gmail.com>
Message-ID: <CAHk-=wghSiMXEaWq6MA6C8ye8-Wek7WmnkWYpCNwv=N8R+rQgg@mail.gmail.com>
Subject: Re: [GIT PULL v2] probes: Update for v6.5
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 18:13, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Probes updates for v6.5:

Heh, after five emails, this last email still ended up being a
confusing mess where you had apparently cut-and-pasted things into the
middle of the email, so things still showed up twice and jumbled. I
don't know what odd mix of auto-generated and manually edited content
causes it.

But hey, the end result is an understandable if slightly messy email,
so I've pulled it.

             Linus
