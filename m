Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6E26B87F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCNB7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCNB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:59:52 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A5F964
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:59:15 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DF9FE9210B7;
        Tue, 14 Mar 2023 01:50:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 212A8920D95;
        Tue, 14 Mar 2023 01:50:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1678758654; a=rsa-sha256;
        cv=none;
        b=8Umcoy/eo5+arqVc3uP0nZwdkwBgS1hIQ+GJT4m6C7WWSLKB3fTB3YmcGiFN2Ee8hD1KP8
        4ESnavRUjghjafWHc5IgXG+mfqy5DMSyNW/v1ozpIl/XKL+NbRRosBkWYj5ehDdRMmHNm4
        KQ5Bwy7hmFa3UaHVY7eUdskCPelh8MiZLcRPl0Y0xXRbdlKw1synoql3lG2x8d87d/tBhi
        qBRBNcGACoASZXKWXR/y3w9rWJOc047jMj13zKdpPzBg2VBlphagPrsy6TsXOxiLXIa03+
        9n8Q13j7e2v1+bDd7X/au5YDYMWNyBzAl+7i1SZp21vLCJkuS/SX6NwaJPo6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1678758654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=CeVq90zpoQPpRIIwvxHQSv+0qiRjCSPI+wnNP15M1+k=;
        b=QgNw5DBchnlvfkc8ZlzadIfG7seuBBAnGKrIzLBXAmOHE62a9TTHtwUmFhdANHLCIf8RqZ
        0gXeY1IbDN66klVrHsoLbz2BSmGhJR3E345PPVWre4wAlKXE6xioz9a1Gb7cCRN1zs0Eeo
        x7QO3u8FGBd0tfquvJF3jtfFxCyyoTi4NnOk7r7XcMaWlYiMobMwq1tEDT4mML0SA7Gd0a
        XjhaHd5GywqYcRnWdxizJfMMKtAkgB8vg6Jw3aLvHiKvDLUeAL4V6PsJ7E1uCtTWY2aF6D
        WO0TWMMV4n0woOFQ4SpZLpPRVYBzu+3JNAgQhDxLGR0ZYOoQBLZI6p/r+iA3sA==
ARC-Authentication-Results: i=1;
        rspamd-7b575b84b5-scwl7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Print: 27b296e03cb36e20_1678758654506_3032418653
X-MC-Loop-Signature: 1678758654506:3492920659
X-MC-Ingress-Time: 1678758654506
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.102.66.52 (trex/6.7.2);
        Tue, 14 Mar 2023 01:50:54 +0000
Received: from offworld (unknown [104.36.30.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4PbGhF11ynz1w;
        Mon, 13 Mar 2023 18:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1678758653;
        bh=CeVq90zpoQPpRIIwvxHQSv+0qiRjCSPI+wnNP15M1+k=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=NWd4+fd9Ah4hDRUxmKoySKU/RhNnaTRT4RDNBDtsRBOJlBPZlx1eDwBcchDuiuNd/
         sKO7OsMzYTw79czSIBRko+AzXXBmSElDyuql7E/AVm0QkVIbDSIdttvjQvBdqRdR1o
         QvGIqQES+PVfwGcXT6MJuUBnk2sc7QiDCc4ZYv6OXeTttfcS8VvLBIb6JCg6JI0AzS
         Wpa8MkTVxY/Lo9TK7c3iBQ/r+FuTAjL/RyQjhXSQ8MQMKa+l+YPFC8NvTy0IwwAnGE
         6yF82jryLFnUstgZgimMAMEuOsETvxxx5b9AkTpk5l0044CC/UkHDfgH6gx1179Do5
         3+/K010UKZYTg==
Date:   Mon, 13 Mar 2023 18:21:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] tmpfs: add the option to disable swap
Message-ID: <20230314012130.3peeuifjjemynklk@offworld>
Mail-Followup-To: Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230309230545.2930737-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230309230545.2930737-1-mcgrof@kernel.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023, Luis Chamberlain wrote:

>Changes on this v2 PATCH series:
>
>  o Added all respective tags for Reviewed-by, Acked-by's
>  o David Hildenbrand suggested on the update-docs patch to mention THP.
>    It turns out tmpfs.rst makes absolutely no mention to THP at all
>    so I added all the relevant options to the docs including the
>    system wide sysfs file. All that should hopefully demistify that
>    and make it clearer.
>  o Yosry Ahmed spell checked my patch "shmem: add support to ignore swap"
>
>Changes since RFCv2 to the first real PATCH series:
>
>  o Added Christian Brauner'd Acked-by for the noswap patch (the only
>    change in that patch is just the new shmem_show_options() change I
>    describe below).
>  o Embraced Yosry Ahmed's recommendation to use mapping_set_unevictable()
>    to at ensure the folios at least appear in the unevictable LRU.
>    Since that is the goal, this accomplishes what we want and the VM
>    takes care of things for us. The shem writepage() still uses a stop-gap
>    to ensure we don't get called for swap when its shmem uses
>    mapping_set_unevictable().
>  o I had evaluated using shmem_lock() instead of calling mapping_set_unevictable()
>    but upon my review this doesn't make much sense, as shmem_lock() was
>    designed to make use of the RLIMIT_MEMLOCK and this was designed for
>    files / IPC / unprivileged perf limits. If we were to use
>    shmem_lock() we'd bump the count on each new inode. Using
>    shmem_lock() would also complicate inode allocation on shmem as
>    we'd to unwind on failure from the user_shm_lock(). It would also
>    beg the question of when to capture a ucount for an inode, should we
>    just share one for the superblock at shmem_fill_super() or do we
>    really need to capture it at every single inode creation? In theory
>    we could end up with different limits. The simple solution is to
>    juse use mapping_set_unevictable() upon inode creation and be done
>    with it, as it cannot fail.
>  o Update the documentation for tmpfs before / after my patch to
>    reflect use cases a bit more clearly between ramfs, tmpfs and brd
>    ramdisks.
>  o I updated the shmem_show_options() to also reveal the noswap option
>    when its used.
>  o Address checkpatch style complaint with spaces before tabs on
>    shmem_fs.h.
>
>Chances since first RFC:
>
>  o Matthew suggested BUG_ON(!folio_test_locked(folio)) is not needed
>    on writepage() callback for shmem so just remove that.
>  o Based on Matthew's feedback the inode is set up early as it is not
>    reset in case we split the folio. So now we move all the variables
>    we can set up really early.
>  o shmem writepage() should only be issued on reclaim, so just move
>    the WARN_ON_ONCE(!wbc->for_reclaim) early so that the code and
>    expectations are easier to read. This also avoid the folio splitting
>    in case of that odd case.
>  o There are a few cases where the shmem writepage() could possibly
>    hit, but in the total_swap_pages we just bail out. We shouldn't be
>    splitting the folio then. Likewise for VM_LOCKED case. But for
>    a writepage() on a VM_LOCKED case is not expected so we want to
>    learn about it so add a WARN_ON_ONCE() on that condition.
>  o Based on Yosry Ahmed's feedback the patch which allows tmpfs to
>    disable swap now just uses mapping_set_unevictable() on inode
>    creation. In that case writepage() should not be called so we
>    augment the WARN_ON_ONCE() for writepage() for that case to ensure
>    that never happens.
>
>To test I've used kdevops [0] 8 vpcu 4 GiB libvirt guest on linux-next.
>
>I'm doing this work as part of future experimentation with tmpfs and the
>page cache, but given a common complaint found about tmpfs is the
>innability to work without the page cache I figured this might be useful
>to others. It turns out it is -- at least Christian Brauner indicates
>systemd uses ramfs for a few use-cases because they don't want to use
>swap and so having this option would let them move over to using tmpfs
>for those small use cases, see systemd-creds(1).
>
>To see if you hit swap:
>
>mkswap /dev/nvme2n1
>swapon /dev/nvme2n1
>free -h
>
>With swap - what we see today
>=============================
>mount -t tmpfs            -o size=5G           tmpfs /data-tmpfs/
>dd if=/dev/urandom of=/data-tmpfs/5g-rand2 bs=1G count=5
>free -h
>               total        used        free      shared  buff/cache   available
>Mem:           3.7Gi       2.6Gi       1.2Gi       2.2Gi       2.2Gi       1.2Gi
>Swap:           99Gi       2.8Gi        97Gi
>
>
>Without swap
>=============
>
>free -h
>               total        used        free      shared  buff/cache   available
>Mem:           3.7Gi       387Mi       3.4Gi       2.1Mi        57Mi       3.3Gi
>Swap:           99Gi          0B        99Gi
>mount -t tmpfs            -o size=5G -o noswap tmpfs /data-tmpfs/
>dd if=/dev/urandom of=/data-tmpfs/5g-rand2 bs=1G count=5
>free -h
>               total        used        free      shared  buff/cache   available
>Mem:           3.7Gi       2.6Gi       1.2Gi       2.3Gi       2.3Gi       1.1Gi
>Swap:           99Gi        21Mi        99Gi
>
>The mix and match remount testing
>=================================
>
># Cannot disable swap after it was first enabled:
>mount -t tmpfs            -o size=5G           tmpfs /data-tmpfs/
>mount -t tmpfs -o remount -o size=5G -o noswap tmpfs /data-tmpfs/
>mount: /data-tmpfs: mount point not mounted or bad option.
>       dmesg(1) may have more information after failed mount system call.
>dmesg -c
>tmpfs: Cannot disable swap on remount
>
># Remount with the same noswap option is OK:
>mount -t tmpfs            -o size=5G -o noswap tmpfs /data-tmpfs/
>mount -t tmpfs -o remount -o size=5G -o noswap tmpfs /data-tmpfs/
>dmesg -c
>
># Trying to enable swap with a remount after it first disabled:
>mount -t tmpfs            -o size=5G -o noswap tmpfs /data-tmpfs/
>mount -t tmpfs -o remount -o size=5G           tmpfs /data-tmpfs/
>mount: /data-tmpfs: mount point not mounted or bad option.
>       dmesg(1) may have more information after failed mount system call.
>dmesg -c
>tmpfs: Cannot enable swap on remount if it was disabled on first mount

Nice! For the whole series:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
