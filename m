Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC726B7616
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCMLe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCMLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:34:35 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9176756537;
        Mon, 13 Mar 2023 04:34:15 -0700 (PDT)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4PZvgn0DxPz4BKKJ;
        Mon, 13 Mar 2023 13:34:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678707253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EF3ReIMvBj+T4PLPaY1HcNa2eGds/OsiXohf+xAW4Vg=;
        b=NSo8K6BPrVzQAmQfbQvLDCV6sRHMtrL6GLJlV2FDKN5MFlyaty+QpwbxX3Zk32g/5oCF2v
        PseDDo3zJnG7/V45519eqsS59dsS3AYoEtdv1iPtvZPd+fOozsJNNKA2gxR737RV/5f9aT
        599Ow10VLHdMtVMO1u4T5vYLxezcwE6/Q72YlS+arvgs6qwPReGqtVVC6GfmxHwoNpT0l/
        J4oT5kTqncHIuOPw1Ci+Zkt0o/Y2V+UGuZ8qs2itDs8y9b3zT5w6hnCApJOcA4vOtM2avm
        mDV5ZnImPjH/TU2M248M4uaG01Xe2lTkI45Sbq6uGgcZLJ/dR9gUfm/rX/KrWg==
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PZvgN6wZdzyRf;
        Mon, 13 Mar 2023 13:33:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678707233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EF3ReIMvBj+T4PLPaY1HcNa2eGds/OsiXohf+xAW4Vg=;
        b=WQxju+3+WaWyv46PRIdOeQZM9MmAoQOIzZRR+j1wiMe3wrdTjd1CxAPZCgbVSjPZQlUTWS
        ErYpwlbiZuexQccsOlYuXS+sMKgASgeeTLtKuj/0cd/l+7WjK7u384ncisYys1eazKpqsx
        UoDzboyv6JkSqileMMvjXtttvQd90HU=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678707233; a=rsa-sha256; cv=none;
        b=mpDSA2pfCw9hsfbzmbC3MG/GpwNLJgBvELsogmj4wrVUloj60Xwt7MBLbQeSEou/MCb50F
        3rdUG2MoANemEtimj2C9FNWTqhw/ST/oEeW/5/3RgBJc/iu0r7seHphk2Ij3xWOcqoqsLr
        cQ7jYNvmYdaV9btY3UPARi2S5rui2ks=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678707233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EF3ReIMvBj+T4PLPaY1HcNa2eGds/OsiXohf+xAW4Vg=;
        b=qGA7fUB0x8HenC7hD2tluMFiSqOrFCq5dbZgC/alHNwUHgEQENFWORF398QEebeL9RGcvl
        KTZ9XpN1F/gvzAmgfq9rovmwRTSihWsWGq8rawUlUDzjn3nGzDd8qxTLIl5fMTdSKRCo6f
        YrKoI8WodGVmOyWXGOQHAhvas2a+ENw=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 697F2634C91;
        Mon, 13 Mar 2023 13:32:55 +0200 (EET)
Date:   Mon, 13 Mar 2023 13:32:55 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Message-ID: <ZA8J5/vElpjrRD4N@valkosipuli.retiisi.eu>
References: <20230209221205.46573-1-andriy.shevchenko@linux.intel.com>
 <Y+V1Hds/yCjABDnL@pendragon.ideasonboard.com>
 <Y+Z5mAhQk6zEFHOz@smile.fi.intel.com>
 <ZAtnKLKEZXCw/Ezy@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAtnKLKEZXCw/Ezy@smile.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 07:21:44PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 10, 2023 at 07:06:32PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 10, 2023 at 12:35:09AM +0200, Laurent Pinchart wrote:
> > > On Fri, Feb 10, 2023 at 12:12:05AM +0200, Andy Shevchenko wrote:
> > > > Since we have a proper endianness converters for LE 24-bit data use them.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Thank you for the reviews!
> > 
> > > I assume Sakari will pick both patches.
> > 
> > I also assume the same.
> 
> Sakari, do you have any comments?

Yes. These are in my tree now.

-- 
Sakari Ailus
