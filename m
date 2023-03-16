Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB706BD2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCPOro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCPOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:47:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15CA618D;
        Thu, 16 Mar 2023 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/QbrHDToz4OYTamtsGa0neSPu+ZWm/jLj9D1wlpmcUM=; b=MqSPb1uZU91VReNokGTYmdasei
        9h6CSvSUd5PC4DBPIOvcNBBE8guMEg+maloDdidLt05jw7/lP2ACGA2sB0YaY7BWcI8YKs9BLpZTb
        1hz8x0B8H79Qqk3IlJfASV0pe3EogpOM+zdtOO4VXgAMQ8iY52wp56YUdRvPAJasZeHZgyv5nstgi
        0yQJgx8ahY40RuYaCjEbY68MXtyCI9TD4OsvnXkD845CUJJ0ojV9YPxqxOJ3R7hfsbgyXNkKYRDv/
        LcAZAw79dOJODtu1FsXHAcRadCayz2Ym4d9hzRyFkULaoQ8AM9H5xxk4zn8LuKFB4ZOCV8Mq+3v+n
        BEc49sbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcosv-00GjQ0-1t;
        Thu, 16 Mar 2023 14:47:17 +0000
Date:   Thu, 16 Mar 2023 07:47:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     MIngyi Cong <congmingyi@gmail.com>
Cc:     linkinjeon@kernel.org, senozhatsky@chromium.org, sfrench@samba.org,
        tom@talpey.com, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v3] fs: add the tuncate check of exfat
Message-ID: <ZBMr9YOmLtC6GNQ8@infradead.org>
References: <20230307135740.13209-1-congmingyi@gmail.com>
 <20230316142753.6628-1-congmingyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316142753.6628-1-congmingyi@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:27:53PM +0800, MIngyi Cong wrote:
> EXFAT will fill zero data in truncated range.
> Fix this by adding EXFAT_SUPER_MAGIC check.

None of these is correct.  We need to find a way to communicate
this information without looking at magic numbers.
