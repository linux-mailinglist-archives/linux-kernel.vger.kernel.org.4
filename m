Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC26591CC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiL2UwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiL2Uv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:51:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F465A46F;
        Thu, 29 Dec 2022 12:51:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2778B81A6B;
        Thu, 29 Dec 2022 20:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B315C433EF;
        Thu, 29 Dec 2022 20:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672347114;
        bh=KD2racd09CWRWSYr+UM/gcKzPGBLEtjPUw7DEP7BMe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4hGThcUk03B+WYSCPxwIBw0ihw3lsfONpfBnDtHms4NyrYWV4SgdZHDf5ivynAax
         SVuLmoFi1oYaNwIZNQN+WmLG5Cg5F31EjP/AhkYuW93n0mvRpbFPQDuzC2w341739h
         yNkgtcpFKLYWRRX3G+IbSaknI5sxghV6+Yusp1HfSaRxecvn4KoMqDvchbnE2uCRtp
         rCUFrU2p/D8um9uF0wyaIXoOjvf4y1Rn4Y3gEVfmogClblgifqZCT12gXDX87LiFkE
         W3pXbr3lj1dl4aCjjxBNMVCI6MyMeqOSKYwbW0UNBjuVjYDfIRlnQrsfce0Fgsuz/A
         0B4FCpSRi+ouA==
Date:   Thu, 29 Dec 2022 12:51:52 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     code@tyhicks.com, ira.weiny@intel.com, fmdefrancesco@gmail.com,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] ecryptfs: crypto: use strscpy() to instead of
 strncpy()
Message-ID: <Y6396PQlotOmKirR@sol.localdomain>
References: <202212280936545669762@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212280936545669762@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 09:36:54AM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.

Unlike strncpy(), strscpy() does not initialize the full destination array, so
it is unsafe in some situations, such as initializing structures that are then
copied to userspace or to disk.  Please include an actual explanation for why
this patch is correct.

- Eric
