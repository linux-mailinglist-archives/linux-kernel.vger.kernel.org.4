Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14726698EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBPIal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBPIaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:30:39 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF3F474C4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:30:36 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id a63so131631ybg.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aV6pFwE43CN4dem5vZuHJChCMbOrTxdF1BMzS4I5thA=;
        b=dR1ZtEmOP3odAC3bEPASdqgIl20IHPzHQkOUvMp1FM1Xp0ykjbimWSPFMMAdZYfYsc
         Di8B93AsFkX/IePgujBt2O9VlkPgcvH49pPV7Iuev9KbQzBveh9OsTjYce19tW69mi0s
         JXbM/InAUtEeDhyS7GnUzJV9aBz6QPTLzEvN/HhYNObLTmbCM7H7hk5qtKWummBqgYw3
         miSDQkMMFAQRHTbcdfk6YCrg/b9AMaslGt9Ku/rcaZ6QtJnnsixBlQfldyYRdH9ObS4S
         Sf6Qf9sO5zGJXX2Tg/0nX/RP8gJySxhw+Te2H+QW+mo7vbG0l5uG0bjn5B383eQ6fFAA
         l11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aV6pFwE43CN4dem5vZuHJChCMbOrTxdF1BMzS4I5thA=;
        b=dY+SlrfLVvnIbKEk2gryAiT/bgeF7OwOL2zN67lw/1tCDa4uHBmzQJdVJ9//FG0/B8
         CkUG5tH/culsaEsgKe2kxxGsY89hkQ2Yh3kWX0Q52ijWQ9VYhC7OOac238r4wTJnngtM
         +nxkhDywtN0DTUX5GsY8qbxP/g6s8UdvDbcrJxmRMzerQoNx0DE61IjjOC6d+VBJVGnJ
         DrGz6iOiT9jXXGEwE3E2G5mK5bakPo59PbzOJSjc32P8hYQG1lqO9G/9JyPjxPZPNbYU
         YYAwm7/l0eB83+jZGfvcJvNVMBHE6x+6xvfnM72m8h2n6wwsWykOk+jyNNChZlDn9Xti
         Y85A==
X-Gm-Message-State: AO0yUKVL/ZY2MZIBIpcjF1qTSSq0YJp5h/n3x/4YnAw3X/0aofeNzRsb
        ax8lLm4fmVA8D9ELLr2s+2pfXPn0NiEkq7lzz8bkhw==
X-Google-Smtp-Source: AK7set9aQOLKtH9O2Hal4NZyH6uriEKubDXvZj7QxBF6mwF4swlyoOv+TuQfEhquM0RKsldDD3QIpRo515xgRrsb59c=
X-Received: by 2002:a25:9983:0:b0:883:cf5:1553 with SMTP id
 p3-20020a259983000000b008830cf51553mr517453ybo.28.1676536235470; Thu, 16 Feb
 2023 00:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
 <20230120154437.22025-4-andriy.shevchenko@linux.intel.com> <736566bd-b8bc-07d0-bb07-b8abb8bc09eb@wanadoo.fr>
In-Reply-To: <736566bd-b8bc-07d0-bb07-b8abb8bc09eb@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Feb 2023 09:30:23 +0100
Message-ID: <CACRpkdYVbMiwWyQtTGezZcZ5UaRL=hy1y5FNHTTkYWQDCySE=Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] usb: fotg210: Switch to use dev_err_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 9:07 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> > -     dev_err(dev, "init %s fail, %d\n", dev_name(dev), retval);
> > -     return retval;
> > +     return dev_err_probe(dev, retval, "init %s fail\n", dev_name(dev));
>
> Hi,
> the patch is already applied, but is dev_name(dev) needed here?

Not really but it's not a big deal either, it's just a string.
Feel free to send an incremental patch dropping it :)

Yours,
Linus Walleij
