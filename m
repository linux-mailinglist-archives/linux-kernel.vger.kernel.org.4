Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9CE6DC774
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDJNwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDJNwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:52:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5495A49ED
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xJiy5asiUhmQxlHjXRXu9kHZp3LovZa44g8LjX7RzaE=; b=LSDK9hfvS470b8r0sjcgHolIMj
        fjCO4XrBHUI/jZPzk6H8Q4gmgsTnOtsF9aD/E+O4cU40BzunkQ2U69NHqeZlByju5NkjbZfN7VvW+
        j5cfaeW+UKixZKr1urBwdEAaU+go2YbR8FWZlyZ/71SlUYqN73b3hzdnIY350Mtp+tFj+DYVNclxh
        M40l1YLgmdA2ThhJpXWz9CgSZz8XaeTUp6h1Xbhbei1VYLnUvwmZNa7ELmZ62x0RGWEerRI1X48IS
        CswZJETP5FiBxshp7iZsk0BbLSa63VfwK4zSxWZ79M89ko/LT2tzY0ErJzcD7zVrJ/FHTpNMMuQjB
        0NF4pJQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1plrvw-004E8M-AG; Mon, 10 Apr 2023 13:51:48 +0000
Date:   Mon, 10 Apr 2023 14:51:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        David Binderman <dcb314@hotmail.com>
Subject: Re: [PATCH] maple_tree: Use correct variable type in sizeof
Message-ID: <ZDQUdK/hht5I9/p7@casper.infradead.org>
References: <20230410091431.74961-1-zhangpeng.00@bytedance.com>
 <8b5af22d-1612-a2a0-02da-728f1fd57bf1@bytedance.com>
 <b1ea2c08-8e88-e04f-417b-4cf0daa417b1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ea2c08-8e88-e04f-417b-4cf0daa417b1@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 06:09:27PM +0800, Peng Zhang wrote:
> Maybe sizeof(void *) is equal to sizeof(unsigned long)
> in most architectures, so I don't know if it counts as a fix.

This is actually required inside the Linux kernel.  The only programming
model I know where sizeof(void *) != sizeof(unsigned long) is Windows
64-bit userspace.
