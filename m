Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6D6A4F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjB0XP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjB0XP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:15:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E8F1F919;
        Mon, 27 Feb 2023 15:15:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 014FACE1068;
        Mon, 27 Feb 2023 23:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAA9C433D2;
        Mon, 27 Feb 2023 23:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677539753;
        bh=xx0PUItNVoebyUpWOIyd9J1C23pNG+cenzOSnMIcA9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQsHqhnPPf2q8vg7dfBs8dHZDj0dWSoQW9gSFUtmOo671XyjWQdUMmeMYlfMa82D8
         sPVPv2k8wgxnJxn31e0t1HCnE0l1iqj7I1IEy5NIS+4jw1ftDfMP/oGU6k8G2glHcf
         xgLrgGTkLERKVcNPl15j+4ZhOKTRXr4AK/keaaff7u3z7o5w+n/aB7p5qrFIOO7NLF
         r433x5kQqyeuW+VjtfLMe1aTHixU4haeQN2b0u0KKTnO77VrFY/ECMDElMfxyv29fG
         pN6GRCWLhGs+1r5KjarMDD86oRKmIfd7FtOIGvZ74Zj+/erp9+/3C8D+0rdqvrnzu8
         Iw9+9Kyve2b1Q==
Date:   Mon, 27 Feb 2023 15:15:51 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Subject: Re: [PATCH] scsi: ufs: support IO traces for zoned block device
Message-ID: <Y/05p0jYrg2wfXw6@google.com>
References: <20230215190448.1687786-1-jaegeuk@kernel.org>
 <Y+3GzX6yMOKUFTh3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3GzX6yMOKUFTh3@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15, Christoph Hellwig wrote:
> Why does UFS even have it's own common tracing instad of just relying
> on the core SCSI one, and even worse pokes into command set specifics
> which is a no-go for LLDDs.  This code simply needs to go away instead
> of beeing "enhanced".

I'm not sure how all the other vendors use the trace tho, at least to me,
it's quite useful when debugging any UFS-specific information such as
group_id and doorbell status along with the attached scsi command, in
addition to the accurate latency measurements.
