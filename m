Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F736E07C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDMHdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjDMHdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:33:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E68C83FA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:33:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE3351FD67;
        Thu, 13 Apr 2023 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681371183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=elDuTEZYayLfJlItl9SNUw9yZs9AzmRif5IZ5ls5h0s=;
        b=o8IWQxY+ZSpakHiqoFFxvwR2xVYTYXDNxqdoTJ/B8QKOtJyibEIVKYHV4VZpwi0j14BTgo
        j2WiH1HF+T0edVx+eP4zioIl8fXSYQkqbCi2xXgCo8c9Cd58OmPUQdDD6MwTVPDjNcwuTP
        WnQmL5hOdDbKaXbNBt7MaP6aESpB6G8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681371183;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=elDuTEZYayLfJlItl9SNUw9yZs9AzmRif5IZ5ls5h0s=;
        b=ZxLuz53dh+LJHclClizKmuZBNjXxFJZacu3mHa3q1b9fgB+E7RjbFAJzA3B3atXcVd1/OT
        j8reFOstx/dehBDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8B9413421;
        Thu, 13 Apr 2023 07:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0LLnLy+wN2QIegAAMHmgww
        (envelope-from <iivanov@suse.de>); Thu, 13 Apr 2023 07:33:03 +0000
Date:   Thu, 13 Apr 2023 10:33:03 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: rmem: Make reserved region name unique
Message-ID: <btjh6exqa5tzxjcqtayyemgm6lyh3cktcqgnd7ofqgtlu2sylp@jm5tcggnvo3z>
References: <20230411135035.106725-1-iivanov@suse.de>
 <437e9983-55e9-3f9d-a94b-c746922973da@i2se.com>
 <r3x3b6fyejqg3ftcgigdrevsnlhbfrae2gztejsa3cnduaebf4@z3reu7bj6b6n>
 <43effe7f-9b2f-52d7-2570-decf2940a58c@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43effe7f-9b2f-52d7-2570-decf2940a58c@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-12 17:10, Stefan Wahren wrote:
> > 
> > I am using RPi4[0] for testing this. Device tree is based on sources
> > from here [1]. From this devicetree it is  obvious what is happening.
> 
> Thanks for clarifying. Unfortunately this file is not identical to the
> mainline file, so the issue can only be triggered with the vendor DTB?
> 

Patch which adds this here [4] is coming ...

Regards,
Ivan

> > [0] Raspberry Pi 4 Model B Rev 1.1
> > [1] https://github.com/raspberrypi/linux/blob/rpi-6.2.y/arch/arm/boot/dts/bcm2711-rpi.dtsi#L57
> > [2] https://bugzilla.suse.com/show_bug.cgi?id=1206846

[4] https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/bcm2711-rpi.dtsi#L56
