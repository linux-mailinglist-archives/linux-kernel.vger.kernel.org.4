Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA14C74EA84
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjGKJ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjGKJ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:29:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D62686;
        Tue, 11 Jul 2023 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P3V/baKr27NERdyCLq3qNzWBANAN0kIdPapyH/jWGeQ=; b=wBArNjMLFJHfCiS1BW1cfJXaGR
        ta3KAYmFbZipVdyTkZ43tqArntzpXWn4W/1jLwXaowm6fWhzZwC2BBr83wIS/AObocNiGNyBLHNnp
        dyWhhz+eIFjWZZIY00OaQ72j7TiUoIDAlEHmL67Ij/R8jJhNhBjO2yj2dZg9bNqBOREX44rrGBCl8
        jQqQ+jm5hzzFFd0D80jSexaNqFxGO98JR5G189BeINtuExMKfxc7C2tp9/uuQUFpsummqZCP+7AYL
        IxM+AQsmrmW/K1uCwVKqp3GcaPwN46F6psfNsu01FcvKEvG0p+q01kjnBfFKiTclUUeV6+xs/iwQd
        FTZRbQrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ9eM-00EHmw-0c;
        Tue, 11 Jul 2023 09:27:14 +0000
Date:   Tue, 11 Jul 2023 02:27:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Message-ID: <ZK0gcj4j/sRWx2Pl@infradead.org>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
 <ZKuqt6QAXic3wuRX@infradead.org>
 <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
 <ZKvQPAN9OkS3dZ4d@infradead.org>
 <87a5w3ymff.fsf@metaspace.dk>
 <ZK0RKkXFaQSotxVl@infradead.org>
 <875y6qzufc.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y6qzufc.fsf@metaspace.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:02:15AM +0200, Andreas Hindborg (Samsung) wrote:
> 
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Tue, Jul 11, 2023 at 08:23:40AM +0200, Andreas Hindborg (Samsung) wrote:
> >> Yet most on-the-wire protocols for actual hardware does support this
> >> some way or another.
> >
> > Supports what?  Passthrough?  No.
> 
> Both SCSI and NVMe has command identifier ranges reserved for vendor
> specific commands. I would assume that one use of these is to implement
> passthrough channels to a device for testing out new interfaces. Just
> guessing though.

Vendor specific commands is an entirely different concept from Linux
passthrough requests.
