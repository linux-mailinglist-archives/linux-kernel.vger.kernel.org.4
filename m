Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FE7420FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjF2HaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjF2H36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:29:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8151FE7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:29:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992ace062f3so45190966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688023795; x=1690615795;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=s5nGGw5gvPHiYhCADwmQXV7PL7CPhqenUtZ/ZGNPhyk=;
        b=FecDdIDCDGjKQnAkDLrNfxBzQgNPyKHtyCp/sXn/Io9r4tUWa8G/pVqxGdKU1Zhhiv
         4UEDRHX/xSBASiG73ttGLR+OvaxQ/JuzBbH5aT+RTImnKkHKoqEzMSDdueUdcKDWLlcZ
         lPtbx9DIIik0XUeq+MSwXohACSIqUqCgpWgKh3fuI2szFBaJDs9vrnD/hWaiy+JWYp5u
         QCdY2FSKiXuTbevAaUOA/Z/ljh90+/XtPnis2HFE1jhZ1SuLUOJJ4Fu+AoQsuOIernV3
         1qeDFNAb61HHocFkfmOPwe1amncovMFPQKd0clrVtpxlPqhU8W0sZoxkCsU3K/PJaFGW
         2ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688023795; x=1690615795;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5nGGw5gvPHiYhCADwmQXV7PL7CPhqenUtZ/ZGNPhyk=;
        b=awmKykF5P6Rgf66vEXkK9Fk56tGFmcJjpJ+6Q0zHpaWg54gq5XcoXsgs63oRSG5J6A
         yH2gz11+ZlCNU7b04dzEzZZv/c8RvjEoT+8qqTAJkDMntMsx8KsmLah6B7eD0IawjDew
         a3XagPtaoDhL0ZYpwY8A+UKGyU5ewH72BzXtJp70AReGQFUAfcLtJrraSlet+qeM2gw+
         gEqi90OrEQE61mS4K0+eGEzST8QCiySqVREgLw7aTq9oGCSXoao/XOm9u1AALQisajwD
         4AlKbZX/3wO7HIB6uD4M9Qf/7+v0zzVDdOMEl1rkUfpqLox/lhHm+K/667l6deCURT8Z
         FAIw==
X-Gm-Message-State: AC+VfDwCaUfniJDyfDoA3VM+jkEAkoyrSX1kuV7x14+ne0UDagMl3doM
        Wac/5OrMSzNKflcCGpkv/JmbhA==
X-Google-Smtp-Source: ACHHUZ5kzvNl4uQvDPstO0o4laP2SbJB9IDXUab/0LqsWirbwRZ7JyJlxeuThpTm6cG6qhYj9Ts10A==
X-Received: by 2002:a17:906:9b86:b0:982:21a1:c4e0 with SMTP id dd6-20020a1709069b8600b0098221a1c4e0mr35643468ejc.56.1688023795459;
        Thu, 29 Jun 2023 00:29:55 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id br7-20020a170906d14700b009893b06e9e3sm6552996ejb.225.2023.06.29.00.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:29:55 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk> <ZJ0ZAmpNpid8Ff08@infradead.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Date:   Thu, 29 Jun 2023 09:25:32 +0200
In-reply-to: <ZJ0ZAmpNpid8Ff08@infradead.org>
Message-ID: <871qhuzpxr.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@infradead.org> writes:

> What's the point in having a separate file for about 100 lines of
> actual code?  Especially as that needs a header, intefaces, etc?

This was suggested by Niklas [1] to make the conditionally compiled code
more readable. The alternative would be masking out the code with a big
`#ifdef`.

If you prefer the latter, I can change it back, no problem. But I must
say I think it comes off cleaner when we move as much as possible of the
zoned code to a separate translation unit.

[1] https://lore.kernel.org/all/Y%2Fy+UFEHn1F1sg4i@x1-carbon/
