Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6066F44E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjEBNUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjEBNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:20:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D6618B;
        Tue,  2 May 2023 06:20:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 321D61F8C4;
        Tue,  2 May 2023 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683033645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7GpKexF8PKYlMflbIamvM1M1ucLUjNPY3jJqsyR6dk=;
        b=jizMv7db6T6JUqrCWUu3dSq6QAWTlcyLubBf0610O4jBuWcuvWrbwNMe/LDQLax9Uoj51d
        7m8FXBuvmGzHRUOM9yUmD2ytXwQtHhaXy9RqmGh6TXjhbWSGGOIQIGtkdNPkwghfGT3yAx
        4MF+eh9ErYVqXOC/YmwHHKMNt/SfH3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683033645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7GpKexF8PKYlMflbIamvM1M1ucLUjNPY3jJqsyR6dk=;
        b=NCnm75FdcJx2skes/nq92wID9BXMet3GFpktZYy5oXdrmF8pSa5738PsPn3DMm+sx9HqDF
        aF6Pk5vEaIHJCcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24A1C134FB;
        Tue,  2 May 2023 13:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jwTlCC0OUWS2VwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 02 May 2023 13:20:45 +0000
Date:   Tue, 2 May 2023 15:20:44 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Message-ID: <i52iedwcrbg4zvx7t4rv7rkt2lgd4gnaklmpl7cd6s2yh2a4iy@eap3hhllfpzb>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
 <s4xicrnevbwapdwvw5wl2z4bpm6vv6q62lcgimy6wcqnbf6tbo@u7alfvt4bmen>
 <6odezvt3uwnc3c6353qlvqdxadmn5giihsj77xvwi6h4655la4@ezvpevwxfsan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6odezvt3uwnc3c6353qlvqdxadmn5giihsj77xvwi6h4655la4@ezvpevwxfsan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, AFAIK, bash arithmetic supports integer only. I tried below, and bash did
> not return floating value...
> 
>   $ avail=90000; echo $((avail/1024))
>   87
> 
> Assuming bash arithmetic supports integer only, -1 will not be required in the
> calculation.

Can't remember how I ended up with the above. Anyway, works just fine without
the printf.
