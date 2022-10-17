Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4262D60060E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJQEuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJQEuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFA2A419
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 21:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B2060F1F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EA1C433D6;
        Mon, 17 Oct 2022 04:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665982221;
        bh=zP+QWZVvD/g/7FLG+RNOCKnRNoV+tb39fjJoguMZEdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUFPxp4Fmx6nPNVRnAl5xAtGwHVTYtTQhe04+XKOrniM5/eloE4hEDs046xE83Def
         hPcUfJnlEtskuG3XC0SVVxIMpKzmgH2kn/E8JwhDpmg9TNshPhXnyLmapGKHHvQTAr
         Fk6miAl2K9rDFXTHw3aGpi2Ugb3G9m9IdFO1stXg=
Date:   Mon, 17 Oct 2022 06:51:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH] kobject: fix possible memory leak in
 kset_create_and_add()
Message-ID: <Y0zfPKAgQSrYZg5o@kroah.com>
References: <20221017023327.1793893-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017023327.1793893-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:33:27AM +0800, Yang Yingliang wrote:
> If kset_register() fails in kset_create_and_add(), the name allocated
> in kset_create() will be leaked.

How is kset_create_and_add() failing?  Is this in a real kernel, or
created with a fake fault injection?

thanks,

greg k-h
