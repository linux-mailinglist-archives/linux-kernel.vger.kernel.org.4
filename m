Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03F2715D12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjE3LYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjE3LYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74538138;
        Tue, 30 May 2023 04:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A03562741;
        Tue, 30 May 2023 11:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD52C433EF;
        Tue, 30 May 2023 11:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685445828;
        bh=ZVKevbhOi3dzPmyJza980ajLwMtxRIrR4uviPlUa+A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbrcdvGsLzurlPrOBYMkRNI1hTWwWfA0rF31VaibC7KUfqMbINONjVrTUO5zUeoDT
         nBpn5wokj0OwXAQphyrclam1/VLQG6LTJ+kghgDsU+i20fS6xbjtjTRckfiwwi3ZO+
         jBNgFeb6NZnkTkPEGCxDej8I47dQA0vDRa4KvTUs=
Date:   Tue, 30 May 2023 12:23:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, felix-haase@siemens.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/10] tty: n_gsm: expose configuration and statistics
 via proc fs
Message-ID: <2023053053-cider-canopy-36ae@gregkh>
References: <20230517155704.5701-1-daniel.starke@siemens.com>
 <20230517155704.5701-9-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517155704.5701-9-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 05:57:03PM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> The n_gsm mux collects various statistics about the mux and its channels.
> These are currently not exposed to the user. There exists already a proc fs
> path for tty ldiscs (/proc/tty/ldisc).
> 
> Extend this path by an 'n_gsm' node and create a proc file for each mux
> instance if active. The file exposes protocol statistics and channel states
> and configuration to the user. Mutex based locks are introduced to avoid
> inconsistent states.
> 
> The following shows an example output:
>  tty:ttyS1 flags:
>  initiator:1 mode:1 mru:64 mtu:64 t1:10 t2:34 t3:10 n2:3 k:2 wc:0 ka:100
>  bad_fcs:0 malformed:0 io_error:0 open_error:0 bad_size:0 unsupported:0
> 
>  dlci:0 state:OPEN cl:2 prio:0 i:UIH k:2 mtu:64 tx:35 rx:35
> 
> Description:
> tty:         The underlying device used by this mux.
> flags:       Tty flags relevant to the mux protocol.
> initiator:   0 for responder, 1 for initiator.
> mode:        0 for basic option mode, 1 for advanced option mode
> mru:         Maximum receive unit size.
> mtu:         Maximum transmission unit size.
> t1:          Acknowledgment timer.
> t2:          Response timer for multiplexer control channel.
> t3:          Response timer for wake-up procedure.
> n2:          Maximum number of retransmissions.
> k:           Window size.
> wc:          Wait for configuration before starting parameter negotiation?
> ka:          Control channel keep-alive timer (0 if disabled).
> bad_fcs:     Number of bad FCS.
> malformed:   Number of malformed frames.
> io_error:    Number of I/O errors on the underlying tty.
> open_error:  Number of failed DLCI open attempts.
> bad_size:    Number of n_gsm frames with bad size.
> unsupported: Number of malformed control frames.
> dlci:        Related channel number.
> state:       Current channel state. Possible values are CLOSED,
>              WAITING_CONFIG, CONFIGURE, OPENING, OPEN and CLOSING.
> cl:          Convergence layer type.
> prio:        Priority.
> i:           Framing. Possible values are UI and UIH.
> k:           Window size.
> mtu:         Maximum transmission unit size.
> tx:          Transmitted payload size in bytes (incl. convergence layer
>              type header).
> rx:          Received payload size in bytes (incl. convergence layer type
>              header).
> 
> All timers are in 1/100th of a second units.

Please no, procfs is NOT for driver/device statistics like this, that's
what sysfs is for if you really need/want it.

What userspace tool is going to read/parse this thing?  Where does it
live?

And what about the security issues involved with all of this new data
that you are now exposing to all users?  Has it been audited to verify
that it is safe to do so?

thanks,

greg k-h
