Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55807374CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjFTTAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjFTS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:59:51 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673BBDC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=0ST5VG4BIdQiX6233KO3FjWHkUQ73kaQaZzR2i8Y6sI=;
        b=m6qRYyHA5niL4yMsF2Asz8e/06380DiQa/ER43LTkJdlH2FjfUHsF89ZPiT+qLn3mSWGrK7i69mHi
         0Q7qnRii9A2nQPxXULsaHgyW/ooXSuhbiaL9RQQWqcYMco3xOCDXa0XlMczVZQOnGL1ch8uUNnvlDn
         dlw7w3suKfB/oyai6aSg8UdroqwCIfi/OecTF44KzcceY7K4y4G3afFuKYKcxgyslA4DOHnvAKaq+j
         UIhiTeGDdXnbR0l17vaMU2vPfsXHEq9ScU22RCr43P0ctTuIhrWvJ5OY6W2n+7ikgMvdi+tPdzGBGJ
         Xn2cW3evSqw3Wl5ZZ1qgSLuIhw5FJgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=0ST5VG4BIdQiX6233KO3FjWHkUQ73kaQaZzR2i8Y6sI=;
        b=VdQBxQIO1EeIUYFmhdJdNRQjn26Dazp/FK5E6d3ZM+2XTdCWh/6drmhHIQE1fx3tC+L2tF8UEeKlK
         gsL6+JSAg==
X-HalOne-ID: 9e591c9f-0f9c-11ee-a09a-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 9e591c9f-0f9c-11ee-a09a-b90637070a9d;
        Tue, 20 Jun 2023 18:59:46 +0000 (UTC)
Date:   Tue, 20 Jun 2023 20:59:44 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] oradax: make 'cl' a static const structure
Message-ID: <20230620185944.GB2192874@ravnborg.org>
References: <20230620183446.684061-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620183446.684061-2-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 08:34:47PM +0200, Greg Kroah-Hartman wrote:
> From: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Now that the driver core allows for struct class to be in read-only
> memory, move the 'cl' structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at load time.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
> Cc: sparclinux@vger.kernel.org
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
