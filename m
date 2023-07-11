Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8237C74E8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjGKIWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGKIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:22:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8890191;
        Tue, 11 Jul 2023 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qwuo2cmnOyKWMhs51uip+VVO1uccisKrt4zrIgmUcvQ=; b=jvp1svZdBq8Y4YpYYuoVxg/q8n
        a9UCIH+MHHb5EXp3PuUPDhv0FhMYQ+wW+pAb2oaf9mijPY66kxtbP9rsiowfWLKrdmoDtmcVDSNOd
        rNDvx0Sgy46rh9bvIHhshESc/FlazgPHAJY8NJqRKLKFX9mqPVGSiJNbA40UTI9xwgCarfkXXn8pz
        a5N1EPYo5FrfSPCVg5yw1BmC8Ly5BAwzcRW01/w0QeKMeTdVjQpvk7kg99HLYWrGYChUE4RdZZgvz
        rreBNt7M11s1ncS93G60LwDE0ndJeX2f3SV9MdsJZyYwSQ2C0SCZWQiHsO3nZwGYSIVyRwA4BeWOL
        8E44roig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ8dG-00E5jN-1N;
        Tue, 11 Jul 2023 08:22:02 +0000
Date:   Tue, 11 Jul 2023 01:22:02 -0700
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
Message-ID: <ZK0RKkXFaQSotxVl@infradead.org>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
 <ZKuqt6QAXic3wuRX@infradead.org>
 <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
 <ZKvQPAN9OkS3dZ4d@infradead.org>
 <87a5w3ymff.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5w3ymff.fsf@metaspace.dk>
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

On Tue, Jul 11, 2023 at 08:23:40AM +0200, Andreas Hindborg (Samsung) wrote:
> Yet most on-the-wire protocols for actual hardware does support this
> some way or another.

Supports what?  Passthrough?  No.

> I somewhat agree in the sense that for consistency, we should either
> move zone management commands to the DRV_OUT range OR move report_zones
> out of this special range and just next to the zone management
> operations. I like the latter option better, and I would love to see the
> block layer do the same at some point. It feels backwards that
> report_zones get special treatment all over the place.

DRV_IN/OUT is purely a Linux concept.  It doesn't make any sense for
a wire protocol.
