Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22815BE1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiITJOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiITJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:13:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844136E8A2;
        Tue, 20 Sep 2022 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=st6ywYd7QNObrvixOrGm70gXZhtQqy3HFcSnVxpobEk=; b=alniaSqsEuJGIx4isdzq5zi/wr
        Tp5iLRAuHSEVv5ZfqESAXem3Kas/e6awxipcv+Mc7ACop9F3AU3nSAF9IvQ+a08J1rmYa8GlkQB4W
        khfE2SD6bS7qlrPp3g6jl9Ec4yPToD5mWC7oAtnjQzurjFf+ynATNF7olIpn7CigwERlNKj7Wf5rr
        m/Y7CGrbdlaM90HnEYKISBAeP75RpbGEkzE+o9qWnnAQ5A7D7EV06crwpFAE+HePbNyY5e+cVipD1
        S20tzDC8F6gWqIDGxusOrvQdnU3sdq8erGI4Qv55GMMejm9EwmX5PRh2K+s2lra+Mj7DBeGh3Z9O9
        HWms2lNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaZIg-002FYy-Te; Tue, 20 Sep 2022 09:12:19 +0000
Date:   Tue, 20 Sep 2022 02:12:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Joe Konno <joe.konno@intel.com>
Subject: Re: [PATCH] ata: ahci: Enable/Disable ATA Staggered Spin-up by
 default
Message-ID: <YymD8ncMTUrAqAeL@infradead.org>
References: <20220919094635.184804-1-ecurtin@redhat.com>
 <Yyleq43/IBofsMMn@infradead.org>
 <CAOgh=FxMBE_YEC89DmeF9g76aQXrvAH1DvUavS1FhNiXqEYhAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=FxMBE_YEC89DmeF9g76aQXrvAH1DvUavS1FhNiXqEYhAg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:04:20AM +0100, Eric Curtin wrote:
> The libahci.ignore_sss flag is something that is set by a number of
> performance focused distros. The motivation behind this is to set
> ignore_sss in a boolean fashion at compile time rather than depend on
> cmdline parsing.

So set it in CONFIG_CMDLINE if you want it enabled at compile time.
The whole point of a built-in command line is to not add another
Kconfig option for every bloody option that someone wants a default
for.
