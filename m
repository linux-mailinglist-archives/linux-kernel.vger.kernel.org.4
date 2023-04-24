Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF586ED420
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjDXSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjDXSL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:11:29 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDA46EAC;
        Mon, 24 Apr 2023 11:11:26 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2C38B5C176A;
        Mon, 24 Apr 2023 18:11:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9FC4F5C0F80;
        Mon, 24 Apr 2023 18:11:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682359882; a=rsa-sha256;
        cv=none;
        b=AZvnCETqaJWrbR/KXJjP8h/fR2udp8hNHI9Prf/2ziuDnRfYFLIBu4+z/xTWlYmoviK1nx
        6PNQ1UiwFzl9yQEYcfsKY3E7O94ycxakR5YbMqfyOHhs08GV5dw0B/nAa/7jjN3L0zvWES
        uWCh4XmfGWRYNUb4HFv5TPyQDIffd9yxjWZhMaOA69zbV8wamONi6nAxMi8k4auqm6EC2M
        2Vrjdh4Bv11Vv52KSeVnjteUVLOkOfiyoC/HjWWK+VwCH9I8+g7WMD2l6r9PPs2Hno1SBW
        buOyOEKToYysMURAp9///8z8EC3Ro23VVMVTs9HRRePuW+tKtAqCKtI5D8+iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682359882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2wxLkBR71Y0DyWkZH4ju2khClaI45CxuGX8RryJuv6w=;
        b=KYACSQ+ongq4fPncv5mUn7bl4ZKZqAmLgmiJYSh5Zc8WMh99Cws7xfDPmNlz4ET6OcZC0P
        HISx5daTfGGlzEeB5gPcHhHOdhgntDu1gv4ZMMh1tH+Ljr+Wmets+pSOnMIDIQKsWeJ4ju
        2JsJGhTxLs8LcKdZ30LD972MbyPLy/x+yKl+6Q8wx8XGZWs7W6dsWk9bTQp7uUlzW+BLcT
        By8x0Eue6+Oi5HULfvp0P21yEKZubR4nVZbWbi+MxZaX7nlhOJyjivvwPyf2C5jIW8x1C9
        8q+VSqZIjNC4/+dYNJsLPhxRmsWpC7b4OBSgrTNdUFQzKjWW1TA3vYdD9F7IDw==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-zjhh9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arch-Turn: 7d8e6e43170ce28d_1682359882951_2513165092
X-MC-Loop-Signature: 1682359882951:845671132
X-MC-Ingress-Time: 1682359882951
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.114.243.17 (trex/6.7.2);
        Mon, 24 Apr 2023 18:11:22 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4Q4tVd6Qtmz3K;
        Mon, 24 Apr 2023 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682359882;
        bh=2wxLkBR71Y0DyWkZH4ju2khClaI45CxuGX8RryJuv6w=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=i7g6EhAUdC28M8k6dmzTcZex8+SkB3kSq4XU78hRl7xv0Drfzi68GmLhm6osQdeLg
         eM4+1s2fDlxBYGVpcVl6U75u+AID/zqwlE2GV96K3mjC3aVqs23KwFnHVsMVCRjfTp
         rNHlIm3ApoYQg6QrJJhL3kTuI04EW7ta4biRw8FkOhA9H9CWnQpCT3PeTARNoNNeJD
         CtwOpLSSwNVx7zMFipvoe56dKPsyL4hT17zHK9fDvGbDyKIq+lYzF6aolz/k5rucpt
         P5/bVvoUTcYq7t45ROQ7WrBeMQI1ZwrmIVhEbIO/bQu7HvSfV2sYnVKzIgi/hq5BXc
         EyaB94lm2qxpg==
Date:   Mon, 24 Apr 2023 10:39:41 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 0/4] cxl: Add a firmware update mechanism and cxl_test
 emulation
Message-ID: <y4cqp7r3tt74igqwtcbwshcca66krcjpiopo6frilx272x6ot7@ji2shc7sqk27>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
User-Agent: NeoMutt/20230407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023, Vishal Verma wrote:

>The poll interval for the Transfer FW command is arbitrarily set at 1
>second, and a poll count of 300, giving us a total wait time of five
>minutes before which each slice of the transfer times out. This seems
>like a good mix of responsiveness and a total wait - the spec doesn't
>have any guidance on any upper or lower bounds for this. This likely
>does not need to be user-configurable, so for now it is just hard-coded
>in the driver.

Nothing against this, just thinking that in general, but we should
probably limit the poll interval to CXL_MAILBOX_TIMEOUT_MS. I'm not
sure, however, what would be a proper value across all commands. Or
would having this limit be per-cmd make more sense instead?

Thanks,
Davidlohr
