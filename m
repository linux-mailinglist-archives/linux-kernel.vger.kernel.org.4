Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F389737A70
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFUEtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFUEtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC99129;
        Tue, 20 Jun 2023 21:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67F7361470;
        Wed, 21 Jun 2023 04:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450A1C433C8;
        Wed, 21 Jun 2023 04:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687322945;
        bh=y6P2q6HkJrP6E+BmNyePqPuzpnfkzYRar4brXTlVguo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUcJ9ejpSri1qvPY+/GTlfuzb6tmMOH2CfwaMMrrYECHO7HRP5yZ14Y8JBx2+EH/K
         CHbscO9s//W/C52JzxBqAUdYefzYz4c0Ol2D3jeX8QMc+KFlvUb6MEMSJnchVMwlhj
         D1KACC9dciMdfc6AHM/sU2HsnqiCoQVLQG4jYG2wmRPsMnPOvW57lpWH4OJ6Z7NJwt
         K2NPrJXp/tq8Uiokac+1w7BDg2DuOBhoZT4FFFlXP5wJPIgCHbc/6L63GnD/NHeXRD
         q8XVbjYAI16ieq0DXMJx1SO8ZdAcm9Lt+c8Sse8NdY7+6ooFU3ad2CCcO+TFkyJze6
         TcWDDnSaG981Q==
Date:   Tue, 20 Jun 2023 21:49:03 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] ythermal: core: report errors to governors
Message-ID: <ZJKBP3YR63i4otsf@uf8f119305bce5e.ant.amazon.com>
References: <20230519032719.2581689-1-evalenti@kernel.org>
 <20230519032719.2581689-7-evalenti@kernel.org>
 <CAJZ5v0hrddGcoqdT6a0+9t20guW_1cZmbNhP_ZuQTmkCLGSKEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hrddGcoqdT6a0+9t20guW_1cZmbNhP_ZuQTmkCLGSKEA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:29:57PM +0200, Rafael J. Wysocki wrote:
> 
> 
> 
> On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
> >
> > From: Eduardo Valentin <eduval@amazon.com>
> >
> > Currently the thermal governors are not allowed to
> > react on temperature error events as the thermal core
> > skips the handling and logs an error on kernel buffer.
> > This patch adds the opportunity to report the errors
> > when they happen to governors.
> >
> > Now, if a governor wants to react on temperature read
> > errors, they can implement the .check_error() callback.
> 
> Explaining the use case for this would help a lot.


Yeah I agree. I also did not send the full series and will also add
the governor changes for this in the next patch series.

The use case here is primarily when temperature reads can fail.
Common use case, not limited to though, is an I2C device temperature sensor.
While it can be, in many cases, reliable, it is not always guaranteed to
have a successful temperature read. In fact, it is common to see a sporadic
temperature read failure, followed by successful reads.

This patch series will enhance the core to allow temperature update
error communication to the governor so the governor can have the
opportunity to act upon sensor failure.

-- 
All the best,
Eduardo Valentin
