Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00066F64B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEDGIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjEDGIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:08:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C730ED;
        Wed,  3 May 2023 23:07:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5748422172;
        Thu,  4 May 2023 06:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683180474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IUM+ERx3EDZgrOPmitrrEsrUJVeKyyrvviQgqmi2R4g=;
        b=1Pq5gZX8lay9YuC+jmoHsx/xW60owt4wdm3IGEuZGMYZROn3+HDKkHgBhAgIpCzriHFSGr
        yBOs91KTh/HSVEvpFXLkAwFBLBFHuK7qz7wkUabqnVa/KTMfL0vtdCIQ0jyHFlKr/7i+lP
        FwIbA9p3qulHh7g0krdIksEAeSIYdlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683180474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IUM+ERx3EDZgrOPmitrrEsrUJVeKyyrvviQgqmi2R4g=;
        b=7l4M7iGr6Mko3IrDhlMWz6ZP/ueaGdrX6XLFDUPNLx0bufCuEJpvZTPpcFn1lGbwFAwQ0Z
        T/mgujD8GwALJ1DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 416A1139C3;
        Thu,  4 May 2023 06:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id osFlD7pLU2RiZgAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 04 May 2023 06:07:54 +0000
Date:   Thu, 4 May 2023 08:07:53 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 09/12] common/fio: Limit number of random jobs
Message-ID: <qksy7pmx4n2l2pbpos33x4nnhp5vwjqlnk72lycxk4benjtqfa@vewobmlevbj4>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-10-dwagner@suse.de>
 <99a6cc5f-31b2-787c-f448-53239a351ddd@nvidia.com>
 <2ercejt6r2qjkbpaoueh66nred4ooqb5wskx5m3xn2slb5kasw@zwssje3pm4mu>
 <ec72542d-a554-59ac-8f67-26eeb7f2a5b0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec72542d-a554-59ac-8f67-26eeb7f2a5b0@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 05:16:34AM +0000, Chaitanya Kulkarni wrote:
> For this series to merge let's keep is simple and not worry about erroring
> out on a particular job size but just keeping the nproc as it is ...

Works for me and as you pointed out, it avoids regressions with the default
values. Anyone who is tinkering with nvme_img_size should be aware of the
implications. I'll add a note about this to the documentation.
