Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839266F43B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjEBMXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEBMXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:23:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F7F5;
        Tue,  2 May 2023 05:23:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1CF3B1F8BE;
        Tue,  2 May 2023 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683030189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rpq/YOA2Q6NcOyBEqPAtPKwqdnVr3RL2S8jyTOYKx38=;
        b=E5aokJVmN+jHpsNd8DP9p105k0emCQTSinruXmu1ftje8AFOFPqifHIr20RRU45v5R0EkX
        3+6Ybnq8FpRRlcJ1+403QG6JiojNfSG/tigO1MGc3nD2+PDhHJvBGzWMuSG//jEr46Xoap
        qvMgIEcWCV64sDbPjzXHNLVvQHEWqnU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 231412C141;
        Tue,  2 May 2023 12:23:08 +0000 (UTC)
Date:   Tue, 2 May 2023 14:23:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Konrad =?iso-8859-1?Q?Gr=E4fe?= <k.graefe@gateware.de>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Message-ID: <ZFEAq7r-awo0OYzp@alley>
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
 <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-04-28 08:56:59, Rasmus Villemoes wrote:
> On 27/04/2023 13.51, Konrad Gräfe wrote:
> > The CDC-ECM specification requires an USB gadget to send the host MAC
> > address as uppercase hex string. This change adds the appropriate
> > modifier.
> 
> Thinking more about it, I'm not sure this is appropriate, not for a
> single user like this. vsprintf() should not and cannot satisfy all
> possible string formatting requirements for the whole kernel. The %pX
> extensions are convenient for use with printk() and friends where one
> needs what in other languages would be "string interpolation" (because
> then the caller doesn't need to deal with temporary stack buffers and
> pass them as %s arguments), but for single items like this, snprintf()
> is not necessarily the right tool for the job.
>
> In this case, the caller can just as well call string_upper() on the
> result

I tend to agree with Rasmus. string_upper() is a super-easy solution.
One user does not look worth adding all the churn into vsprintf().

Best Regards,
Petr
