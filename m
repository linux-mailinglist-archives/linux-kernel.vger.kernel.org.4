Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381FD5FA6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJJVAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJJVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:00:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F53A310;
        Mon, 10 Oct 2022 13:59:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b15so10793475pje.1;
        Mon, 10 Oct 2022 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69QNkeF1VMU19p8EHpHj3PcPL5WDz7Vr/ECBHT1RXr0=;
        b=gGs410RbjPWYOOhiCE4Y86Xaq5V6Q8wkMGtxMfuk29VmbBh6MIRcfXhlnGvM7EvLno
         D5d5Y93CgM7I8biJKs93RORzV6o0YmqXhYP7k/REr8KV3Q6oP2XptNtqOOQcx1b81JSj
         PKqa8/7hCQlLgkewOpu0KlKlJwhA6oYzT0nMC+I7FbeHlC5pzqFIGQjrs0bboivbqRjF
         VALlvYMB1CwfVN8+d4Mry/aUfuudwejdqdehpQ6stvVywWfacRffYUH9Aay4H6qWRICC
         5LMReGBidZXUshUYPCRQAEHlXi6+ARDikGz0JEaBNZ8k5cuHkBP1s0wKptiqTMiu5sKA
         ie7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69QNkeF1VMU19p8EHpHj3PcPL5WDz7Vr/ECBHT1RXr0=;
        b=EiiiFrwYmxqXkJatnab5fih3qxl00cgrp7AONKcGGbcgwfzHZm/o2SXYiF+tG0qvQP
         CtN2qAmoJeYXto0GZtLlqP5xmGRlokCd6b109SF5QSB772DkusJNaPaprMNKPigWUJ7J
         B6JFfaev/o/xcz9VqRSQMulq58+ienhfr/Mr47AAz5WE+KkGuOWduhyU1/j79/Lf8SSw
         /S+XPdxnZWVpCWTR7XOXEKjw7l788flQbI4wa/4kPSwsocrf2JLS+HWCBtVQpEN+F3H3
         ubZT57ejPxoe39BpkFpfown+4S90mjefhf05091KwP2cQJ5fWv7ufwyUOR7fgNJbfocl
         7ARA==
X-Gm-Message-State: ACrzQf0AU6QNMwPDvI70WjbElXYhlDcBiYpG1JupStv6itINN0eNI+iq
        Wroj0WD4MlRTj66+sYM4mCU=
X-Google-Smtp-Source: AMsMyM7ypkryDKcLvgzs+zm8KfLFAztr+G5QMu4sZ94VxKYaNKfodmgD4wVDtv+dsdAokH7yhq0A5g==
X-Received: by 2002:a17:90b:78e:b0:205:c9ae:21f9 with SMTP id l14-20020a17090b078e00b00205c9ae21f9mr23066714pjz.112.1665435589523;
        Mon, 10 Oct 2022 13:59:49 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090a154a00b0020d48bc6661sm1884835pja.31.2022.10.10.13.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:59:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 10:59:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the cgroup tree
Message-ID: <Y0SHw8VaKkcEKaT7@slm.duckdns.org>
References: <20220912161812.072aaa3b@canb.auug.org.au>
 <20221011075748.3db42926@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011075748.3db42926@canb.auug.org.au>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 07:57:48AM +1100, Stephen Rothwell wrote:
> This is now a conflict between the tip tree and Linus' tree.

The conflict and resolution were noted in the pull request. This should be
fine.

Thanks.

-- 
tejun
