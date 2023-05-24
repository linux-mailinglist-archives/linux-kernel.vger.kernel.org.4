Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE09871009E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbjEXWIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjEXWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:08:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBB7122;
        Wed, 24 May 2023 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=/JToQHdkxgbDyu1xaJQwVWxSodxYnloGI/u4TaisGIw=; b=c9zMLElgRCGRia6SL8BuLKzB7B
        Mq+Qz2ZTPnhGMkg0GqFoMp8NImins+kYcs+UlKaemxvTM9avgqVIft1UaVmAM9iPgY6bsqW2N9UcD
        GitGvwsNHQxiFG9f8hEtykExK9rUUHyTd6y3HFt/7lsJPwgsvGCa2SPXxLfuONcbljL0O7kn/HK/a
        ujZGfNbX5tv7OqaDvhqDQ3rikEiwcj6GKTPRRcHz0XKhM/FS9p0K7wsuioA/p6BK5z/Kjw8r8SKhY
        NE6gzr+49AfB4wU6dqYtEyGR/xflH8FHzNBLCEoBJwdnh+rP+Y15Z/R63lCDLuDRK2sjFFjjui8Ga
        jgjZVgVw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1weA-00Em4l-06;
        Wed, 24 May 2023 22:07:54 +0000
Date:   Wed, 24 May 2023 15:07:53 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     david@redhat.com, tglx@linutronix.de, hch@lst.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate
 detection
Message-ID: <ZG6KueWpHnyPr6YV@bombadil.infradead.org>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
 <CAHk-=wi9oPrxcMK469X0zAueKQ4tqX80SdFqCx9StcL82vuEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi9oPrxcMK469X0zAueKQ4tqX80SdFqCx9StcL82vuEkw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 02:56:47PM -0700, Linus Torvalds wrote:
> On Wed, May 24, 2023 at 2:52 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Stop adding horrific code for some made-up load that isn't real.
> 
> Even if you trigger some "worst case 3x memory use", that is
> _temporary_, and will be free'd in the end.
> 
> The patches to "fix" this are worse than the disease.

Fine with me, we can punt back and wait and hope udev fixes this.
No one can tell me I didn't try. Now let's hope userspace will try
an alternative.

  Luis
