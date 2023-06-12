Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A772CBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbjFLQhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjFLQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B579E4A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC61F615FC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4A6C433EF;
        Mon, 12 Jun 2023 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686587825;
        bh=tVyrfzsCwApI/MUrmD7XF9CxwLI7I10+d8agdZfnyt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQ7MyhaIv2iiaDMMPE5S1/B09zcu2u2qCB5PjHn0KMt7W/ZHcn4tUyV+kFBo87mke
         2YeX3oeNXvfh7OH8nLSN+YXOxZwF+Q3hqSdoMc26s1zscg047Sm5XkGGl5oLyvfs13
         s/CYn5dsD1/1lXZI3QuWJ+hqsXKG2yGm6KR9jvMI=
Date:   Mon, 12 Jun 2023 18:37:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "jim.tsai" <Wei-chin.Tsai@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, mel.lee@mediatek.com,
        ivan.tseng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/1] process: export symbols for fork/exit tracing
 functions
Message-ID: <2023061226-repugnant-upstate-a2b4@gregkh>
References: <20230612151545.17810-1-Wei-chin.Tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612151545.17810-1-Wei-chin.Tsai@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:15:41PM +0800, jim.tsai wrote:
> +static void class_create_release(struct class *cls)
> +{
> +	/*do nothing because the mbraink class is not from malloc*/
> +}

Then the code is totally broken and wrong :(

Please just use the misc device api instead, it is much simpler and
doesn't have these types of errors.

thanks,

greg k-h
