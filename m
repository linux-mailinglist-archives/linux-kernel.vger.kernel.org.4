Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA02710308
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjEYCr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEYCrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:47:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BFE6;
        Wed, 24 May 2023 19:47:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae852a5330so6791135ad.3;
        Wed, 24 May 2023 19:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684982843; x=1687574843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=waGgXS3UilhxJBlU/7X+6sK1z9vQnB/U1MGRAmCqN1U=;
        b=Z6VM/6aQ4CaXb3UhIWRKxxqadrZU/PjSAmQMG0Euj/39aRbtColTQDq9l5lJSzqnr+
         5Gnp9gYsvGxLEmCPH2fEtC4ojvd155Z061X2fkjQyxoRLsJQ32uD0hu46pmI/UNhB8T5
         bLx4NfogNM5iyVzvyIq67q9cFjOlPhjD9J2i/QDjlLh1Bpplvo3lr4UN9XxPeGCnJtqw
         2Ng3+//sR32my8951juR7XXpgovzu8CE562BIEO8m0KsmOZOiRyZ41FP1Wyavb7EIbUT
         aSopQc40VsUfE6ttRg7+dCMHJanV8EwkyDlND3VnbAB8S5mBn8ymeqmDq7JVfCGhcemp
         bn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684982843; x=1687574843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waGgXS3UilhxJBlU/7X+6sK1z9vQnB/U1MGRAmCqN1U=;
        b=YCVoZAvmOno9qxX+GRjk6WoVSuExGBCIcjH5+f/Zqud8gUc7++nxq3AFZNyN6qp3V/
         HrLbXA6iX7HN8I2RLylsNRDsXvW2aKkBta1ClRWueQIm7ojjG6w3jONb97jspe80Efm1
         0WdCPHzAmJvN1Xt523PCUabYF7fRVPcjdVcPP/ATtgjMpgNGw9uBeuI2m1V0ZNJmhRSU
         i4tN1Kd6RIejwbyALYHITT4de9ueQ0fmnJaXk5Xz1Q2Fn4KV31nY+Xa70ArprFKI1G3H
         I+/5GzqMDjccnjOca8h8jhrfCoCWdQanGssCfXbgCl/k4u2P1qPXyOya2BSTFDLmm+b+
         vEyw==
X-Gm-Message-State: AC+VfDwfm10au/vjR6mV0BhyCp9kt7xQe35Xcq1sb0kN939sct4lVja4
        PuUmwCLYGDWbquA3+1msNgjPifDZ3Cg=
X-Google-Smtp-Source: ACHHUZ6230VMPMogqHSv0qMnrQJYuiDguIxh2YUT8IXw91nGsPC8RFkZFjmQKCZ0L4NbXab4Lcioqw==
X-Received: by 2002:a17:902:a507:b0:1ae:29a8:d6d0 with SMTP id s7-20020a170902a50700b001ae29a8d6d0mr15019plq.59.1684982843510;
        Wed, 24 May 2023 19:47:23 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b001a922d43779sm177603plb.27.2023.05.24.19.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 19:47:23 -0700 (PDT)
Date:   Thu, 25 May 2023 10:47:18 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: fix a crash on line-request release
Message-ID: <ZG7MNjYLt6SduWtn@sol>
References: <20230523155101.196853-1-brgl@bgdev.pl>
 <ZG1TLBsOy4mZQlW3@sol>
 <ZG1x5pcyTN2Fio4J@sol>
 <ZG2USw7TTdFSRZ3E@sol>
 <CAMRc=MeRfCoj7bcf-GKrRY3Mp5SEhmb289g=JAHBK-01aERCtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeRfCoj7bcf-GKrRY3Mp5SEhmb289g=JAHBK-01aERCtw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:42:13PM +0200, Bartosz Golaszewski wrote:
> On Wed, May 24, 2023 at 6:36 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> Interestingly enough, I did test it just like you and the "fix" seemed
> to address the issue. Upon a further look at the code, it's of course
> clear that the patch is wrong.
> 
> I wanted to debug the code to see what's happening exactly but it
> turned out that enabling the generation of DWARF data hid the issue as
> well even without any fix. It means that it's some kind of a memory
> corruption rather than a regular NULL-pointer dereference.
> 
> I'm not yet sure where the crash happens exactly other that it's in
> the irq domain code.
> 
> Anyway, I'll be back at it tomorrow.
> 

I was also playing with a patch for gpiomon to have it add POLLERR to
its poll() to see if it would notice the chip removal and exit.
It didn't, it just stayed blocked, but it DID made the crash go away
when I killed it.  No idea why that would be.  So yeah, weird things.

This was the patch, btw:

diff --git a/tools/gpiomon.c b/tools/gpiomon.c
index c2684c2..f4251fc 100644
--- a/tools/gpiomon.c
+++ b/tools/gpiomon.c
@@ -431,7 +431,7 @@ int main(int argc, char **argv)
                                   resolver->chips[i].path);
 
                pollfds[i].fd = gpiod_line_request_get_fd(requests[i]);
-               pollfds[i].events = POLLIN;
+               pollfds[i].events = POLLIN | POLLERR;
                gpiod_chip_close(chip);
        }
 
@@ -452,6 +452,9 @@ int main(int argc, char **argv)
                        if (pollfds[i].revents == 0)
                                continue;
 
+                       if (pollfds[i].revents & POLLERR)
+                               die_perror("error polling for events");
+
                        ret = gpiod_line_request_read_edge_events(requests[i],
                                         event_buffer, EVENT_BUF_SIZE);
                        if (ret < 0)


I expect to add that, or something along those lines, if hot removal of
chips from the kernel ever works like it should.
In the meantime it is just another curiosity.

Cheers,
Kent.
