Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E43737E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjFUJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjFUJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:02:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA6F19B7;
        Wed, 21 Jun 2023 02:02:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B93C221A44;
        Wed, 21 Jun 2023 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687338144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7PPqDZAmzcbcg0rWIZX01hC1JN4/nlDeRusA0hxj38=;
        b=PVbKK07wbYQLl7N/k95ONxfqybkfrZz3Sd26AdMOljQkkvKs23hIY62UaiM9Yy+Qngxl8n
        yBiRGjeD0Jc/PbHIpI7bTatZKg8TksnWrmoErbcArSB4teDzgJAE1hYXZhmw0ttzZsMsqi
        SYGYLE3S4HqNGpkY0m9LMBJFvxE5uGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687338144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7PPqDZAmzcbcg0rWIZX01hC1JN4/nlDeRusA0hxj38=;
        b=2dZQ1LcBI9BComcRh1bGM2eti1X2u0XXMJpg/eBfRfeZmpsO4M+ZXDu7K9iLxfuT+1wVK4
        yrxg3tEzF7/qjICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAA31134B1;
        Wed, 21 Jun 2023 09:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WzqeKaC8kmQrZAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 21 Jun 2023 09:02:24 +0000
Date:   Wed, 21 Jun 2023 11:02:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <ouked4rirrquxur3zzkzm2tsnjtdyfme4hqzetd7hyudtneuhl@feetyajbpqcq>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <af640019-b867-d488-0443-797a75ba4195@grimberg.me>
 <vbbbnzcm6r4jzcc54crix7kjsg647w57te7t2weu7vhuwxg54n@u6cwcn62bfbd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbbbnzcm6r4jzcc54crix7kjsg647w57te7t2weu7vhuwxg54n@u6cwcn62bfbd>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:43:35PM +0200, Daniel Wagner wrote:
> On Tue, Jun 20, 2023 at 05:07:43PM +0300, Sagi Grimberg wrote:
> > Hmm... is this hapenning with non-fc as well?
> 
> I haven't seen a problem for TCP or RDMA yet but in principle it should also
> exists. I can do some tracing to see if we have also problem thern. Two of the
> udev rule match on the subsystem and the event type.

The only udev rule which gets triggered during blktests execution is this one:

# nvme-fc transport generated events (old-style for compatibility)
ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
  ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
  RUN+="@SYSTEMCTL@ --no-block restart nvmf-connect@--device=none\t--transport=fc\t--traddr=$env{NVMEFC_TRADDR}\t--trsvcid=none\t--host-traddr=$env{NVMEFC_HOST_TRADDR}.service"

That explain why blktests didn't get disturbed by the autoconnect rule as this
rule has a match on the fc subsystem.
