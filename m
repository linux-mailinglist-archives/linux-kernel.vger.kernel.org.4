Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483CA7119EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbjEYWDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEYWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:03:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB36186;
        Thu, 25 May 2023 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=Dj12sdoI3n4fpjZdW0Mzq4hB0XZbrqL+DPd7Ji5TGNg=; b=OCLj4wLliabHMtFkwS9TdrlBTx
        +sUQHLscg7D3U1XckQR1AU8vIZlREBIbja6Flm4wCq352iuput5TrOvIRI7Am1m5KRbQTAH3nwl8H
        WV4YsWtwhQCEm0g2Dxz7qwfimujPNEESegH7q3eG7jiG72nxyegVOAZ56wYoV9fCZ6hY4lpVZ75O4
        l+gIpkKAusosIkiByfIzuBG6VUnilFxNyHUgpmn3TYH+4puMfaHaFuAKS/xK9R2nAE9ywUcqJn58e
        SDQtg4WdbbSdKs8coQaiRFvXzhTMiA4xctL2MRr5islutX65JKi673zyZeqTVc0ugTorkYue+n/KC
        vE2uTTKQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2J2Y-000GXY-2w;
        Thu, 25 May 2023 22:02:34 +0000
Date:   Thu, 25 May 2023 15:02:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
 <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 02:12:49PM -0700, Linus Torvalds wrote:
> On Thu, May 25, 2023 at 11:45 AM Lucas De Marchi
> <lucas.demarchi@intel.com> wrote:
> >
> > Are you willig to merge (a possibly improved version of) your patch
> > or the userspace change is still something that would be desired?
> 
> I think a user space change should still be something that people
> should look at, particularly as the kernel side patch I'm willing to
> accept doesn't catch the "completely serial" cases, only the "trying
> to load at the same time that the same module is literally busy being
> loaded".
> 
> But I've cleaned up my patch a bit, and while the cleaned-up version
> is rather larger as a patch (mainly because of just also re-organizing
> the finit_module() code to do all the 'struct file' prep), I'm
> actually pretty happy with this attached patch conceptually.
> 
> In this form, it actually "makes sense" to me, rather than being just
> clearly a workaround.  Also, unlike the previous patch, this doesn't
> actually make any changes to the basic kernel_read_file() set of
> functions, it's all done by the module loading code itself.
> 
> Luis, would you mind testing this version on your load? It still won't
> actually handle the purely serial case, so there *will* be those
> spurious double module reads from different CPU's just doing the
> things serially, but the exclusive file access region has been
> extended to not just cover the actual file content reading, but to
> cover the whole "turn it into a a real module" part too.
> 
> Also, this does *not* update some of the comments in the module
> loading. I changed finit_module to use "kernel_read_file()" instead of
> "kernel_read_file_from_fd()", since it actually now has to look up the
> file descriptor anyway. But the comments still talk about that
> "from_fd" thing.
> 
> Anyway, this is back to "ENTIRELY UNTESTED" territory, in that I've
> compiled this, but haven't booted it. The changes look obvious, but
> hey, mistakes happen.
> 
> And the commit message is just a place-holder. Obviously. I won't sign
> off on this or write more of a commit message until it has had some
> real testing.

With 255 vcpus:

Before:

vagrant@kmod ~ $ sudo systemd-analyze                                            
Startup finished in 41.653s (kernel) + 44.305s (userspace) = 1min 25.958s        
graphical.target reached after 44.178s in userspace.  

root@kmod ~ # grep "Virtual mem wasted bytes"
/sys/kernel/debug/modules/stats    
 Virtual mem wasted bytes       1949006968                                       

So ~1.8 GiB.

After:

root@kmod ~ # systemd-analyze 
Startup finished in 35.872s (kernel) + 41.715s (userspace) = 1min 17.588s 
graphical.target reached after 41.594s in userspace.

root@kmod ~ # cat /sys/kernel/debug/modules/stats
         Mods ever loaded       66
     Mods failed on kread       0
Mods failed on decompress       0
  Mods failed on becoming       1
      Mods failed on load       0
        Total module size       11268096
      Total mod text size       4149248
       Failed kread bytes       0
  Failed decompress bytes       0
    Failed becoming bytes       474688
        Failed kmod bytes       0
 Virtual mem wasted bytes       474688
         Average mod size       170729
    Average mod text size       62868
  Avg fail becoming bytes       474688
Duplicate failed modules:
              Module-name        How-many-times                    Reason
                   cryptd                     1                  Becoming

root@kmod ~ # du -b /lib/modules/6.3.0-next-20230505+/kernel/crypto/cryptd.ko
475409 /lib/modules/6.3.0-next-20230505+/kernel/crypto/cryptd.ko

So yeah definitely a pretty good improvement. Sometimes the system boots
without any duplicates at all, for some reason Vs the previous attempt.

Tested-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
