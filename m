Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF60656D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiL0RJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiL0RJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:09:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF83B491
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qSISMw7MDq754PJkgLb1MOK6jarnJMSK1VgU5WOFP+s=; b=aZhzR+9cjBxFNS69QT2d7G0qBT
        QPDpe4o2G6nrD347jQTx/8/UpPpzcP2Zqe2mpq8VKVnj1pHA6tT05eAFH8fb5fm+ixMohmYSYWbwK
        IsbDba1SQq/8CL9BJZQ0ZvsGtGAwyoqtaHgDw7gi0vRCGn9QGAegGsx5bTTDxDsb2PPlAqYEVyCzQ
        hNGuu4M7m0zyMQbuQab7rSWQZ8qmZ/4CGKqh2siN4rBretnzHELU7Ye01rJe00G4hx1tPMTYmjNey
        pt/RiG94u+NT/g9vCn7uG/DSXRExbijqMXg5Fo83Haa3juN5OA5rMInZ/y1qyib1fI/q/y1vHZTKX
        gojRiz2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pADSQ-00EmvA-6V; Tue, 27 Dec 2022 17:09:42 +0000
Date:   Tue, 27 Dec 2022 09:09:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com
Subject: Re: [PATCH v5 3/6] coresight: configfs: Add in binary attributes to
 load files
Message-ID: <Y6sm1gXTER/XaggE@infradead.org>
References: <20221219234638.3661-1-mike.leach@linaro.org>
 <20221219234638.3661-4-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219234638.3661-4-mike.leach@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:46:35PM +0000, Mike Leach wrote:
> Add in functionality and binary attribute to load and unload
> configurations as binary data.
> 
> Files are loaded via the 'load' binary attribute. System reads the incoming
> file, which must be formatted correctly as defined in the file reader code.
> This will create configuration(s) and/or feature(s) and load them
> into the system.

Binary attributes are intended to pass things such as firmware
through.  Defining your own structured file format seems like a
major abuse of the configfs design.  What's the advantage of this
over simply using an ioctl?
