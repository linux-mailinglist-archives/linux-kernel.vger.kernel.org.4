Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9E25FA310
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJJR6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJJR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:58:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4C77EAB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gXJyMs2OSPDhCkEvqWP7QOCysCbcI9dfM5n2nlK7y4M=; b=vMY7Y5qYn1dGkFns1uBGhntDcK
        yDpsX0cqCD0d+X9Umyj7Z3jQkSlN87bNdzXHyeXIKFetvG4lpL+XZx902eLFPYna7CytqZkV7cGbq
        1Ak+WtZbwAIM2HzV+TFYSUkuihsb2REcusx+G0Z1pu1Z8wVvPdALGIYBgeJq+57qml4x1xrD+sf1v
        3HJ5qqRw2OlPPlhIWbubWHQRJFuvxInMXHEHQH2qXqXJdd8hoP0ar7ia0QPFv/lhXalckdgiilKZ0
        /4VyOYQQ+bkg5O1L3q5tWFnWA6x4BkeuS1GySPbUhpErtYIHg08fjLeyCDzdHfmlmE1HpbS2fvXbS
        ate7Zqyw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ohx26-009G76-1k;
        Mon, 10 Oct 2022 17:57:42 +0000
Date:   Mon, 10 Oct 2022 18:57:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sumit Garg <sumit.garg@linaro.org>,
        Phil Chang =?utf-8?B?KOW8teS4luWLsyk=?= 
        <Phil.Chang@mediatek.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Message-ID: <Y0RdFni5N6rMsxuM@ZenIV>
References: <20221002002326.946620-1-ira.weiny@intel.com>
 <20221002002326.946620-3-ira.weiny@intel.com>
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
 <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
 <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>
 <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
 <20221010074234.GA20788@lst.de>
 <CAHk-=whvmR98OHdYf4yOJgp86hq0VMVXJ9b1Qk7P_Rjq_=HU+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvmR98OHdYf4yOJgp86hq0VMVXJ9b1Qk7P_Rjq_=HU+A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 10:20:15AM -0700, Linus Torvalds wrote:
> On Mon, Oct 10, 2022 at 12:42 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > I suspect the best long term option would be to just pass an iov_iter..
> 
> Hmm. Yeah, that sounds like a workable model, and solves the problem
> JensW pointed out with my simplistic "just pass a page array" approach
> where you also need to keep track of how to release things.

Except that then you need to get iov_iter_get_pages analogue that would
work for ITER_KVEC, which is exact same problem right back.
