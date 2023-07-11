Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9672B74E9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGKJJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:09:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968E122
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:09:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so19518021fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689066562; x=1691658562;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1swa4llGSXPw+jbFQXW+RCE6a2/ZAHCllhqOXijpO4=;
        b=l1t99zHiC+k4/p3uRtVNlxKbiRNR2A7yRQwdHGJPo6VlW2xElMmPrl77gzkkLCgbug
         vPC86dBrEp1cUW7zPSvoKboT1k+DvM5uJTcX3KUlRyciZy+/3FNwdyBbu1PO7H+byS7B
         3OW9Dn8zTX/GpPDPalHk+0T6z1SxyywxPbvVOegBSuVxUQhVjemXMOy9sTIddh9Df35K
         0JaKvEQiK+nnqyhZlxtC764LbzWG5e0ZY9M/ncCCmsHD8W0tbAWVbGamtYj7HdXxWH8n
         oZC9z9RUjyqc7Lig8u1YNB9WPGZS9vwqDFCn4g9eF84Jc61VDAyUww/cBqB2GSOcX9zo
         D+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066562; x=1691658562;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f1swa4llGSXPw+jbFQXW+RCE6a2/ZAHCllhqOXijpO4=;
        b=L+Lzob0kRHXw9y6oigSAlQLC5MOhhBJ4yUrRQ4TCHgwuMr2NSbjH2Zvu5C46F2cy6F
         sC2V3xNk/5rQvkMACvjWWsMiBPeRbZI+ChcqoDcgCGxI0OftuauH/A/b+HdNBO6KNIv3
         HAnRlDwULOIyzA+qBUKAubhNU6vOSFEwwD74goSufUSfIJ9C2ozCg03pYYFawLUubJ5W
         cn4xft4kPbF90eeuhxFNySnzLZTn4s6scCENuxvn8leIBYWadcVvfvao0/yEsFYyO5JS
         1jDxHoB7haY0DZf7xuJMVMKFNPNheSmYxmU+uHWLOo5h/kl1d3jZfGPzAxlKzq479n3C
         P6FA==
X-Gm-Message-State: ABy/qLbwBjvuDRqFAcTOu95lbiW/IY4LWWChmJwvrAivwgQtMNeiGeCV
        zpOw8mzEQJncZaKStxK4cDohKQ==
X-Google-Smtp-Source: APBJJlFyemvbTSempmrSKpT8WCzWbYTuF/fF0IbXO7M8fwe1Xt21ZQ8MG+1x/z1GNhOnEJTNBRAVaw==
X-Received: by 2002:a2e:aaa4:0:b0:2b6:ffa4:d6ec with SMTP id bj36-20020a2eaaa4000000b002b6ffa4d6ecmr6967135ljb.4.1689066562420;
        Tue, 11 Jul 2023 02:09:22 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id f15-20020a2ea0cf000000b002b6f8d07d30sm359557ljm.134.2023.07.11.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:09:22 -0700 (PDT)
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
 <ZKuqt6QAXic3wuRX@infradead.org>
 <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
 <ZKvQPAN9OkS3dZ4d@infradead.org> <87a5w3ymff.fsf@metaspace.dk>
 <ZK0RKkXFaQSotxVl@infradead.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
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
Date:   Tue, 11 Jul 2023 11:02:15 +0200
In-reply-to: <ZK0RKkXFaQSotxVl@infradead.org>
Message-ID: <875y6qzufc.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Jul 11, 2023 at 08:23:40AM +0200, Andreas Hindborg (Samsung) wrot=
e:
>> Yet most on-the-wire protocols for actual hardware does support this
>> some way or another.
>
> Supports what?  Passthrough?  No.

Both SCSI and NVMe has command identifier ranges reserved for vendor
specific commands. I would assume that one use of these is to implement
passthrough channels to a device for testing out new interfaces. Just
guessing though.

>
>> I somewhat agree in the sense that for consistency, we should either
>> move zone management commands to the DRV_OUT range OR move report_zones
>> out of this special range and just next to the zone management
>> operations. I like the latter option better, and I would love to see the
>> block layer do the same at some point. It feels backwards that
>> report_zones get special treatment all over the place.
>
> DRV_IN/OUT is purely a Linux concept.  It doesn't make any sense for
> a wire protocol.

Ok =F0=9F=91=8D

BR Andreas
