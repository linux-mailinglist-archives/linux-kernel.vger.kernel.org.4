Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF2E5F84AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJHJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJHJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C53A5FC7;
        Sat,  8 Oct 2022 02:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBA0D60A5A;
        Sat,  8 Oct 2022 09:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05B9C433D6;
        Sat,  8 Oct 2022 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665222679;
        bh=x13HOIyD9suTVaFon3YOufV/ukJs++5vFFe4lyLKq8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ucw/4c33UnsaixjglaVysYOQszO9SclUkKPpu4TblPcpqpDbAEsifY4ZLQGzhzWNM
         mIx5OqB5x06BuuN3HL4HxNBXNk7K/N4x2FKfLJiJjqJLYayNOw1uxO5haIhMQx1ekf
         isFo1ffZtrZZMtAeGHLHPgFrA2T6xgE7iTcFMyQU=
Date:   Sat, 8 Oct 2022 11:52:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhou Furong <furong.zhou@linux.intel.com>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/14] tty: gunyah: Add tty console driver for RM
 Console Services
Message-ID: <Y0FIQd/8B48ld4VZ@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-15-quic_eberman@quicinc.com>
 <YzbePxTF8hRbWNRU@kroah.com>
 <4cb5e7eb-1571-ed91-e1da-b4223a26f41c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb5e7eb-1571-ed91-e1da-b4223a26f41c@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 03:41:53PM +0800, Zhou Furong wrote:
> 
> > > +
> > > +/*
> > > + * The Linux TTY code does not support dynamic addition of tty derived devices so we need to know
> > > + * how many tty devices we might need when space is allocated for the tty device. Since VMs might be
> > > + * added/removed dynamically, we need to make sure we have enough allocated.
> > 
> > Wrap comments at 80 columns please.
> > 
> 
> checkpatch has extend LINE MAX to 100,do we still suggest wrap to 80?

For comment blocks, yes please.
