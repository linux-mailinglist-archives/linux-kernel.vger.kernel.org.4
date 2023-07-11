Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8609E74ED7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGKMBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGKMBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:01:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B6E67;
        Tue, 11 Jul 2023 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yL09riI3y2n7lRul4VrDuI7HTYzktNv07GtSRsYL7t0=; b=Omnd3pZ13VQdAteE+/Wl+iFWbD
        4excywY3qxL8o1WqTyXY4FDWTEtJTLxouePME3G33IwRJvYNzGCznkmODhlCqy2NlQzfACxdeDjPm
        07Uo/JYMEoa+udinX5d+QvhXwp5ebyRLZrqicaS6oLQXD7tET3mXxm+zvYFEIuip4bh2nJYiINHgG
        URa3jcgXMEQ+axzow1RWPz0KkfgG8/4Eiz4OxCUHhGLmLXHq7lY9V0DegC/FTt1OxWzXKhBBMcFgb
        wolUm0m8RtdJcv1I8sScDud3bM9sUWEoB2A203kC0akCTyMQPJ54c4Rg/AbdSwtteQhqxG+pzRocn
        FUt+NvjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJC3P-00Eoef-0m;
        Tue, 11 Jul 2023 12:01:15 +0000
Date:   Tue, 11 Jul 2023 05:01:15 -0700
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
Message-ID: <ZK1Ei0hHlbQE/bI8@infradead.org>
References: <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
 <ZKuqt6QAXic3wuRX@infradead.org>
 <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
 <ZKvQPAN9OkS3dZ4d@infradead.org>
 <87a5w3ymff.fsf@metaspace.dk>
 <ZK0RKkXFaQSotxVl@infradead.org>
 <875y6qzufc.fsf@metaspace.dk>
 <ZK0gcj4j/sRWx2Pl@infradead.org>
 <871qhezr4d.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qhezr4d.fsf@metaspace.dk>
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

On Tue, Jul 11, 2023 at 12:15:18PM +0200, Andreas Hindborg (Samsung) wrote:
> And yet they are somewhat similar, in the sense that they allow the user
> of a protocol to express semantics that is not captured in the
> established protocol. Uring command passthrough -> request passthrough
> -> vendor specific commands. They sort of map well in terms of what they
> allow the user to achieve. Or did I misunderstand something completely?

Well, there is a relationship, but it's one way.

Vendor specific command are basically always going to be used through
a passthrough interface, because they aren't standardized.

But most commands used through a passthrough interface are normal
standardized commands, just either used in a way not supported by
the normal Linux interface or just in creative ways.
