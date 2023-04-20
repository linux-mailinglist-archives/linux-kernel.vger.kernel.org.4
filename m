Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FBB6E970F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjDTO2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDTO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:28:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E03C1D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:28:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso936881b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682000919; x=1684592919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7m2bRBkBOHO3zCQabT4s8eQkzxK25rqxMEQNCDCJG8=;
        b=Mh7ls9BYeJd6nrKGSNzSZogVNxrX5/on1ypqp2ubGHF/qxAoWC5060Q0bXA4luZ9dT
         0irDpJmeZA9zC6D/Q0JyJbkQv6VqQDX6o4aMEiTCEKxln1xAm8KV1AdaWcLbS/w0zd56
         O4jqyRb5jvMae3hMb2FEmd+2RNaOBpDgSNNKdFXarFtvXQ02tHKmmS9bC7ZVXzJ262vx
         4pslhf3Ws+9BRR+HrPt9eObkRHQWYpRgdGo/d2xhKy3ZR+CG3eoFSX0soW+RSEhlQXQg
         mcimwNe4Wvkma2GCC3b33Y77q9S7q+O7lJFKgbEavCpNaHL3af2lYuhqIW5Alh/B4zSe
         tKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000919; x=1684592919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7m2bRBkBOHO3zCQabT4s8eQkzxK25rqxMEQNCDCJG8=;
        b=JqWmozG9RgMy/qik0NHgWU2KTeDqXvKNbQPMExJCmC2kmHhlH471N5oLa6z66nJTB/
         2gY4rwtbb2TUN6JFMn4W6AJCkfhTDAJQaLSsKpX7b55/exXUSAxk+Z/Fl7oDkAyzdCaU
         0U1DGIWXUBHp6w2NxDl0u9mrwGf1HnVZzGpRdFjsokR4VpbVEBBNvgvPAzR/P3BmqPKI
         G2pRh2BrtEkmI/uiWgEpCVY9otZvmw6ScSvZP3VKlTo+f8/bbJdmQSDoJBtbmsQCy7HC
         q034UAIglklxdKUf42IItKhKgAJcWtBHFICDDekrm7yQCXcwkCtJOSRahJUOshG3b4tb
         X2Bg==
X-Gm-Message-State: AAQBX9eH5tuJvG9VQRRtXtFVnsgS0wxT08Dv4y3Wd6UblsaDpEnCPJIb
        v1bqXYRouUfASCafskq/i8uzAQ==
X-Google-Smtp-Source: AKy350ZnONyViUMEkgdDfpEJ8bskAPktWtd/kGxfjEOb02PH45d5RTnaJpkDOKAn7IX/BeHvJOwU9g==
X-Received: by 2002:a05:6a00:13aa:b0:637:f447:9916 with SMTP id t42-20020a056a0013aa00b00637f4479916mr1908138pfg.16.1682000919388;
        Thu, 20 Apr 2023 07:28:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m8-20020a654388000000b0051303d3e3c5sm1212044pgp.42.2023.04.20.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:28:38 -0700 (PDT)
Date:   Thu, 20 Apr 2023 14:28:34 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH] Binder: Add timestamp and async from pid/tid to
 transaction record
Message-ID: <ZEFMEsPIR3fl/SUV@google.com>
References: <20230413104047.388861-1-zhangchuang3@xiaomi.corp-partner.google.com>
 <ZDm/pLQefIyTBAqb@google.com>
 <CAO+dPF9cb5tQzNkuO4hniTfWesACbr4z2YvT8XKj4afFgyYjjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO+dPF9cb5tQzNkuO4hniTfWesACbr4z2YvT8XKj4afFgyYjjw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 03:14:55PM +0800, Chuang Zhang wrote:
> 
> [chuang]  Android's ANR and Watchdog problems are often caused by calling
> Binder's server interface and waiting synchronously for too long. In order
> to
> confirm this root-casue, we need to let system_server read the relevant
> nodes
>  of binderfs to obtain the transmission when the above failure occurs
> information,
> including of course the time-consuming of the transmission.
> He will help many Android application and system engineers to quickly
> analyze related faults.
> Because we need to obtain time-consuming information in real time when ANR
> or Watchdog occurs, this happens more when consumers use it, and they
> cannot effectively capture atrace, so Perfetto cannot be applied.

Fair enough, this sounds good to me then.

> 
> [chuang]As you can see below, in fact, we only need to print the PID and
> TID
> of "from" when printing binder transaction records in
> print_binder_transaction_ilocked,
> which can be printed correctly regardless of whether it is asynchronous or
> synchronous.
> It is just because the PID and TID of "from" can be obtained through
> t->from in
> synchronous mode, while t->from in asynchronous mode cannot be obtained
> because it is not populated.
> So can I directly add new variables from_pid and from_tid to record all
> transmissions? Does it matter if the naming includes the pid? Greg has
> expressed some concerns about this before .

Right, lets populate t->from_pid and t->from_tid for all transactions
and use those only in print_binder_transaction() instead of t->from.
As Greg mentioned, please add these in a separate commit.

About the namespaces, Greg's comments seem accurate. Binder is using the
task->pid directly so the PIDs would not match those seen by the
namespace. This points to a larger issue in binder as we log these
"raw" pid values everywhere. I'll look further into this and come up
with a binder global fix in a separate commit, so just ignore for now.

Thanks,
--
Carlos Llamas
