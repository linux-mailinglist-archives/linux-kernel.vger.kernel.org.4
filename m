Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7495E6B89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiIVTKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiIVTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:10:30 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2925DAB1B9;
        Thu, 22 Sep 2022 12:10:28 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id q11so6867416qkc.12;
        Thu, 22 Sep 2022 12:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i2fFh03PmN9dsDrlqa6Na6TJ/xoZxneYKaZlpWqCHQA=;
        b=QXRkaQZFyhXLSP5u4FyY7F18yANkzZ8nSltCmZB3/cuc4AkIWpkFrquPxrf8zo/RVN
         SmVo+nB6TMUh/mNq7uN5P8+FSOWNin5j6D8gzWOrK1iecICBwAx8AiRrVqATXQlcze5M
         GBOP107yUe90vIwkQl9OX16UW+bxunOMQPzheyGe376ZgDfU8eeJfwyTTeJSXbe+h65u
         DGrpTwg5QSImJsIu9ey0qiezvAvKG2XnjOkXLkxjYBGDqGyiuTBNBGcLIJVPnWaV+Fvn
         6kif2bfTDDRf06e0+dHgfsq205RS8aZluoR8QqPowxopCSj/v3+kbFtOTQMjKl+iu/Tw
         sdNg==
X-Gm-Message-State: ACrzQf1e4n4kjBhMzuuSYy5rgPY1qpyZQCjv7PXKVEWYInSLEyR278nP
        6XUpDJ6eDvHFahZsfPT+MbWIdNSDLAiykKkPil0=
X-Google-Smtp-Source: AMsMyM7/jpbQTYmB0SMqjZX3zyneGSbRIfxLeeAiexcVjm9d+NWw6CU5BB3SivnMJxe5iDQC8ZGJLwBWnhHx8IuCV54=
X-Received: by 2002:a05:620a:46ac:b0:6ce:3e55:fc21 with SMTP id
 bq44-20020a05620a46ac00b006ce3e55fc21mr3205441qkb.285.1663873826996; Thu, 22
 Sep 2022 12:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220920094500.11283-1-lihuisong@huawei.com> <20220920094500.11283-3-lihuisong@huawei.com>
 <20220921154319.bsczh2nftuypeucs@bogus>
In-Reply-To: <20220921154319.bsczh2nftuypeucs@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Sep 2022 21:10:16 +0200
Message-ID: <CAJZ5v0gfMCw3N1VJmtNU6WPuzrgen-8OiZYFiZkZowo6cFzHwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: PCC: fix Tx done interface in handler
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Huisong Li <lihuisong@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        wanghuiqiang@huawei.com, huangdaode@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 5:43 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Sep 20, 2022 at 05:45:00PM +0800, Huisong Li wrote:
> > A error, "Client can't run the TX ticker", is printed even if PCC command
> > executed successfully. This root cause is that PCC handler calls
> > 'mbox_client_txdone()' which depands on the client can received 'ACK'
> > packet. But PCC handler detects whether the command is complete through
> > the Tx ACK interrupt. So this patch fix it.
> >
>
> Thanks for fixing this. Someone mentioned about the error and it was in
> my TODO list.
>
> I would prefer to reword the subject and commit message as below:
> "
> ACPI: PCC: Fix Tx acknowledge in the PCC address space handler
>
> Currently, mbox_client_txdone() is called from the PCC address space
> handler and that expects the user the Tx state machine to be controlled
> by the client which is not the case and the below warning is thrown:
>
>   | PCCT: Client can't run the TX ticker
>
> Let the controller run the state machine and the end of Tx can be
> acknowledge by calling mbox_chan_txdone() instead.
> "
>
> With that:
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied as 6.1 material along with the [1/2].

I used the above text in quotes as the subject and changelog instead
of the original pieces.

Thanks!
