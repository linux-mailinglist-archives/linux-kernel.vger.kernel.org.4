Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6D74D1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjGJJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjGJJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:33:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80AF10CB;
        Mon, 10 Jul 2023 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ii09KwfW3lRpdYpHvr6Prko3xiz41Lgu8fucaZRBMPo=; b=swa/UZ4GulajGqc19yN6js2z7R
        nX8q01dVRORP1UMEH7t2wRRIAwm7TcLnk41BaEi1nNfqSJVHt+mtNrw25uPzb6Y/4i8E2X6xbpZwy
        3xJJovjOXfjO5++sclzVpTCx/oPg/IvEqm8XQgAR7ERRVEU1BvHp4ihS5LWc9gHhfoqCjHvLd2Khv
        ePElebdIFIE6FboQ6zdx5+i4VvDI6Lm0qC3skIyeTjyJgWD1/2A5oUo3srVes9RnY4HlGTPXydtUz
        oW/UyhAqVWyJJO0NGQp5YA96SVKD9Nz8yu/bpQSe7BU8rDne/jdvo0emvDAYM+CIkn0s83/ioWplp
        hqFFq5GQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qInG8-00B1Go-35;
        Mon, 10 Jul 2023 09:32:44 +0000
Date:   Mon, 10 Jul 2023 02:32:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Message-ID: <ZKvQPAN9OkS3dZ4d@infradead.org>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
 <ZKuqt6QAXic3wuRX@infradead.org>
 <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:27:23PM +0800, Ming Lei wrote:
> Yes, that is exactly what we are doing.
> 
> The added macros of UBLK_IO_OP_DRV_IN_START[END] are just for supporting
> more ublk passthrough commands, and the motivation is for running
> check(such as buffer direction) in two sides easily.
> 
> However, I think it is just fine to delay to add it until introducing
> the 2nd ublk pt command.

The concept of a passthrough command just doesn't make sense for an
on the wire protocol.  It is a linux concept that distinguished between
the Linux synthetic command like REQ_OP_READ/WRITE/DISCARD etc that are
well defined and can be used by file systems and other consumers, and
ways to pass through arbitrary blobs only known by the driver.

Anything in a wire protocol needs to be very well defined in that
protocol completely indpendent of what Linux concept it maps to.
Especially as the Linux concepts can change, and fairly frequently do.
