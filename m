Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E6D74158E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjF1Ppm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:45:42 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:55996 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjF1Pph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:45:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC62361372;
        Wed, 28 Jun 2023 15:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D760C433C8;
        Wed, 28 Jun 2023 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687967136;
        bh=RU+1627RvYZNVLDKwxv7oevX4X2PQ5p+lZZ20WpcPLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNusfO9H0A14G4TrQWXx3xhz/OX8J4zlvzg5I5sVAsJNpVD9pb9BC6pHYDpoMkTKh
         9l4AJnPsCJ8ARS2yfpGLh0bC32HSorxs4DnDmW3L7CAJgbsTQI5+xUbl6RDRBb5+3H
         UwRNNNDV0fHX4L78/lLuwMFYU/W3RSOPXpfDJFfQ=
Date:   Wed, 28 Jun 2023 17:45:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Message-ID: <2023062814-chance-flounder-f002@gregkh>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:04:27PM +0530, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined data
> for first level of debugging on end user devices running on Qualcomm SoCs.
> It is built on the premise that System on Chip (SoC) or subsystem part of
> SoC crashes, due to a range of hardware and software bugs. Hence, the
> ability to collect accurate data is only a best-effort. The data collected
> could be invalid or corrupted, data collection itself could fail, and so on.
> 
> Qualcomm devices in engineering mode provides a mechanism for generating
> full system ramdumps for post mortem debugging. But in some cases it's
> however not feasible to capture the entire content of RAM. The minidump
> mechanism provides the means for selecting which snippets should be
> included in the ramdump.
> 
> Minidump kernel driver implementation is divided into two parts for
> simplicity, one is minidump core which can also be called minidump
> frontend(As API gets exported from this driver for registration with
> backend) and the other part is minidump backend i.e, where the underlying
> implementation of minidump will be there. There could be different way
> how the backend is implemented like Shared memory, Memory mapped IO
> or Resource manager(gunyah) based where the guest region information is
> passed to hypervisor via hypercalls.
> 
>     Minidump Client-1     Client-2      Client-5    Client-n
>              |               |              |             |
>              |               |    ...       |   ...       |
>              |               |              |             |
>              |               |              |             |
>              |               |              |             |
>              |               |              |             |
>              |               |              |             |
>              |               |              |             |
>              |           +---+--------------+----+        |
>              +-----------+  qcom_minidump(core)  +--------+
>                          |                       |
>                          +------+-----+------+---+
>                                 |     |      |
>                                 |     |      |
>                 +---------------+     |      +--------------------+
>                 |                     |                           |
>                 |                     |                           |
>                 |                     |                           |
>                 v                     v                           v
>      +-------------------+      +-------------------+     +------------------+
>      |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm |
>      |                   |      |                   |     |                  |
>      +-------------------+      +-------------------+     +------------------+
>        Shared memory              Memory mapped IO           Resource manager
>         (backend)                   (backend)                   (backend)
> 
> 
> Here, we will be giving all analogy of backend with SMEM as it is the
> only implemented backend at present but general idea remains the same.

If you only have one "backend" then you don't need the extra compexity
here at all, just remove that whole middle layer please and make this
much simpler and smaller and easier to review and possibly accept.

We don't add layers when they are not needed, and never when there is no
actual user.  If you need the extra "complexity" later, then add it
later when it is needed as who knows when that will ever be.

Please redo this series based on that, thanks.

greg k-h
