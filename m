Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3D86E8CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjDTIXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjDTIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:23:34 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6820F35BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:23:10 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202304200823079a6ef4b00f3b966d82
        for <linux-kernel@vger.kernel.org>;
        Thu, 20 Apr 2023 10:23:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cjHoVdDey8j7XpLAFWrYxOo8b5/m43uXRDm1NljxgF0=;
 b=Fg2k/engoflBMYzLA52ybgNj7G64fdU+6lWZk/R17boA6S3uKtQY3A/dPY84ht8dz71MkF
 0Rv0GpDiroXyESfusrKgpeCw7a9DfLBkaX27D7b6y7Wz+ZtiM6q2KT7ZQSzGKa6/GzFc427i
 xAcPeL5apWBflH2DuPWlt37z+f/HE=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     jirislaby@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        yhao016@ucr.edu
Subject: RE: BUG: sleeping function called from invalid context in __might_resched
Date:   Thu, 20 Apr 2023 10:21:53 +0200
Message-Id: <20230420082153.6711-1-daniel.starke@siemens.com>
In-Reply-To: <5a994a13-d1f2-87a8-09e4-a877e65ed166@kernel.org>
References: <5a994a13-d1f2-87a8-09e4-a877e65ed166@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, tty_operations::write() is documented as "not allowed to sleep". 
> But vt's write was always sleeping :D. I wonder:
> 1) can gsmld be switched to a mutex?
> 2) what do other ldiscs do? FWIW n_tty does mutex, so allows ::write() 
> to sleep.

There was already a failed attempt to solve this in the past. But this is
not an easy issue and involves the complete outgoing data flow of the
driver.

Link: https://lore.kernel.org/all/20221205190806.179857803@linuxfoundation.org/

Best regards,
Daniel Starke
