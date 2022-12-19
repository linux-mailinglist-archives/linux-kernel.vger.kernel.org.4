Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A96516D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiLSXrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiLSXqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:46:54 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37FC1114E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:46:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h12so10200820wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=20URghUEhnd48vVWNIo4NcdPqwWP3OApoVFQSqBizbk=;
        b=XrGsIL3zLIGiSSn6zRwToocscYx+EVhRGz0v2L1n/IAjuMcU6xq8ZxA2Wus2Ht6e9N
         S6C2+S60mmYaom7yAsckD8S25Ejvvcqe3F3SJmBbvSPaiKxrPfxWn9DTSgnKDa/+OqNl
         mc9TLU7w9ovr7ziKMBo0UqNMEtE4C3eOa0PQJvlkSW0u6trdiuySdE8p/gNE/utvkkou
         YxAZ+G9dzZdfS0bdLiNYmdOvHB6TpFNjqgitjPcyn3NwIEffSny6Tyt0mxRN66OpK4TU
         YOkTfkTzLeC0IdVDj8ppUq80K+kQFcI4raWg7306COdxXtCPeDg+HudpqicpXG2aegSM
         bZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20URghUEhnd48vVWNIo4NcdPqwWP3OApoVFQSqBizbk=;
        b=WX7SLIRerOMbdhlnaBIGHqX8hcrmiE8uUnm71E10JlCLyyjD2lDzoydtBWmeReabyA
         +shHw8IESOPOm4ncDaSJbNhBibH0Gh608FPM8bXa9IxcdBlUz9brbIxjmXa5FE7B3eVq
         WQ74jfkpydi0luAKD0UYRv99t0jpTtD/5h8REWpSgf9+GNf6AemdtbZdJ8MDGfjTpuFP
         hMq+9HcAYMLoEjSlsyCFWYbiWeIhbGOLyurewag97WBKLJHIcMwprlg4TcFvq3HQFCne
         cVHTnHYdeKNsY+UQbWRUqGVMrzwkQkuESJJjj03DeboVk/qErDZscMwzsuGJvuMuowOY
         6Vjg==
X-Gm-Message-State: AFqh2kp+QcrbJKuwY40KYYrU3BwHqBNsleyLwq9CNJ+G9uZikL3Dgza8
        4u1BRDOAllu5HVEa54oo9hshvg==
X-Google-Smtp-Source: AMrXdXt6JZzeWZ/AtX+SAqVE7wKHSrEQFyPWiwpw8cD02387TMiFxduKOJlehH3NW+aKz7L7W5wBsQ==
X-Received: by 2002:adf:dbc7:0:b0:25d:d243:4f3c with SMTP id e7-20020adfdbc7000000b0025dd2434f3cmr6508350wrj.69.1671493609382;
        Mon, 19 Dec 2022 15:46:49 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:bce1:4a06:7ceb:6940])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b002383fc96509sm11165148wrt.47.2022.12.19.15.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 15:46:48 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v5 6/6] Documentation: coresight: docs for config load via configfs
Date:   Mon, 19 Dec 2022 23:46:38 +0000
Message-Id: <20221219234638.3661-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219234638.3661-1-mike.leach@linaro.org>
References: <20221219234638.3661-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation covering the configfs updates that allow
binary configuration files to be loaded and unloaded via configfs,
along with the demonstration programs in samples.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../trace/coresight/coresight-config.rst      | 202 +++++++++++++++++-
 1 file changed, 195 insertions(+), 7 deletions(-)

diff --git a/Documentation/trace/coresight/coresight-config.rst b/Documentation/trace/coresight/coresight-config.rst
index 6d5ffa6f7347..109053eb1b93 100644
--- a/Documentation/trace/coresight/coresight-config.rst
+++ b/Documentation/trace/coresight/coresight-config.rst
@@ -141,11 +141,11 @@ Mount configfs as normal and the 'cs-syscfg' subsystem will appear::
     $ ls /config
     cs-syscfg  stp-policy
 
-This has two sub-directories::
+This has two sub-directories, with the load and unload attribute files::
 
     $ cd cs-syscfg/
     $ ls
-    configurations  features
+    configurations features load  unload
 
 The system has the configuration 'autofdo' built in. It may be examined as
 follows::
@@ -278,9 +278,16 @@ Creating and Loading Custom Configurations
 ==========================================
 
 Custom configurations and / or features can be dynamically loaded into the
-system by using a loadable module.
+system by using a loadable module, or by loading a binary configuration
+file in configfs.
 
-An example of a custom configuration is found in ./samples/coresight.
+Loaded configurations can use previously loaded features. The system will
+ensure that it is not possible to unload a feature that is currently in
+use, by enforcing the unload order as the strict reverse of the load order.
+
+
+Using a Loadable Module
+-----------------------
 
 This creates a new configuration that uses the existing built in
 strobing feature, but provides a different set of presets.
@@ -289,6 +296,187 @@ When the module is loaded, then the configuration appears in the configfs
 file system and is selectable in the same way as the built in configuration
 described above.
 
-Configurations can use previously loaded features. The system will ensure
-that it is not possible to unload a feature that is currently in use, by
-enforcing the unload order as the strict reverse of the load order.
+The file 'coresight-cfg-sample.c' contains the configuration and module
+initialisation code needed to create the loadable module.
+
+This will be built alongside the kernel modules if select in KConfig.
+
+An example of a custom configuration module is found in './samples/coresight'.
+
+Using a Binary Configuration File
+---------------------------------
+
+The './tools/coresight' directory contains example programs to generate and
+read and print binary configuration files.
+
+Building the tools creates the 'coresight-cfg-file-gen' program that will
+generate a configuration binary 'example1.cscfg' that can be loaded into the
+system using configfs. The configuration declared in the source file
+'coresight-cfg-example1.c' is named 'autofdo3' - the name that will be used
+once loaded.
+
+The source files 'coresight-cfg-bufw.h' and 'coresight-cfg-bufw.c' provide a
+standard function to convert a configuration declared in 'C' into the correct
+binary buffer format. These files can be re-used to create new custom
+configurations. Alternatively, addition examples can be added to the
+'coresight-cfg-file-gen' program::
+
+    $ ./coresight-cfg-file-gen
+    Coresight Configuration file Generator
+
+    Generating example1 example
+    Generating example2 example
+
+The program 'coresight-cfg-file-read' can read back and print a configuration
+binary. This is built using the file reader from the driver code
+(coresight-config-file.c), which is copied over into './tools/coresight' at
+build time.::
+
+    ./coresight-cfg-file-read example1.cscfg
+    CoreSight Configuration file reader
+    ============================================
+
+    Configuration 1
+    Name:- autofdo3
+    Description:-
+    Setup ETMs with strobing for autofdo
+    Supplied presets allow experimentation with mark-space ratio for various loads
+
+    Uses 1 features:-
+    Feature-1: strobing
+
+    Provides 4 sets of preset values, 2 presets per set
+    set[0]: 0x7d0, 0x64,
+    set[1]: 0x7d0, 0x3e8,
+    set[2]: 0x7d0, 0x1388,
+    set[3]: 0x7d0, 0x2710,
+
+    ============================================
+    File contains no features
+
+There are additional attributes in the cs-syscfg directory - load and
+unload that can be used to load and unload configuration binary files. To
+load, 'cat' the binary config into the load attribute::
+
+    $ ls /config/cs-syscfg
+    configurations features  load  unload
+    $ cat example1.cscfg > /config/cs-syscfg/load
+    $ ls /config/cs-syscfg/configurations/
+    autofdo  autofdo3
+
+To unload, use the same file in the unload attribute::
+
+    $ cat example1.cscfg > /config/cs-syscfg/unload
+    ls /config/cs-syscfg/configurations/
+    autofdo
+
+
+
+Binary Configuration File Format
+--------------------------------
+
+The file format is defined in the source file **coresight-config-file.h**
+
+The source reader and generator examples produce a binary of this format.
+
+This arrangement is reproduced below:-
+
+Overall File structure
+~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_file_header]   // Mandatory
+   [CONFIG_ELEM]*        // Optional - multiple, defined by cscfg_file_header.nr_configs
+   [FEATURE_ELEM]*       // Optional - multiple, defined by cscfg_file_header.nr_features
+
+File is invalid if both [CONFIG_ELEM] and [FEATURE_ELEM] are omitted.
+
+A file that contains only [FEATURE_ELEM] may be loaded, and the features used
+by subsequently loaded files with [CONFIG_ELEM] elements.
+
+Element Name Strings
+~~~~~~~~~~~~~~~~~~~~
+
+Configuration name strings are required to consist of alphanumeric characters and '_' only. Other special characters are not permitted.
+
+::
+   my_config_2          // is a valid name.
+   this-bad-config#5    // this will not work
+
+This is in order to comply with the requirements of the perf command line.
+
+It is recommended that Feature and Parameter names use the same convention to allow for future enhancements to the command line syntax.
+
+CONFIG_ELEM element
+~~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_file_elem_header]                // header length value to end of feature strings.
+   [cscfg_file_elem_str]                   // name of the configuration.
+                                           // (see element string name requirements)
+   [cscfg_file_elem_str]                   // description of configuration.
+   [u16 value](nr_presets)                 // number of defined sets presets values.
+   [u32 value](nr_total_params)            // total parameters defined by all used features.
+   [u16 value](nr_feat_refs)               // number of features referenced by the configuration
+   [u64 values] * (nr_presets * nr_total_params)     // the preset values.
+   [cscfg_file_elem_str] * (nr_feat_refs)  // names of features used in the configurations.
+
+FEATURE_ELEM element
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_file_elem_header]                // header length is total bytes to end of param structures.
+   [cscfg_file_elem_str]                   // feature name.
+   [cscfg_file_elem_str]                   // feature description.
+   [u32 value](match_flags)                // flags to associate the feature with a device.
+   [u16 value](nr_regs)                    // number of registers.
+   [u16 value](nr_params)                  // number of parameters.
+   [cscfg_regval_desc struct] * (nr_regs)  // register definitions
+   [PARAM_ELEM] * (nr_params)              // parameters definitions
+
+PARAM_ELEM element
+~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_file_elem_str]         // parameter name.
+   [u64 value](param_value)      // initial value.
+
+Additional definitions.
+~~~~~~~~~~~~~~~~~~~~~~~
+
+The following structures are defined in **coresight-config-file.h**
+
+ * **struct cscfg_file_header** : This structure contains an initial magic number, the total
+   length of the file, and the number of configurations and features in the file.
+ * **struct cscfg_file_elem_header**: This defines the total length and type of a CONFIG_ELEM
+   or a FEATURE_ELEM.
+ * **struct cscfg_file_elem_str**: This defines a string and its length.
+
+The magic number in cscfg_file_header is defined as two bitfields::
+
+   [31:8] Fixed magic number to identify file type.
+   [7:0]  Current file format version.
+
+The following defines determine the maximum overall file size and maximum individual
+string size::
+
+   CSCFG_FILE_MAXSIZE       // maximum overall file size.
+   CSCFG_FILE_STR_MAXSIZE   // maximum individual string size.
+
+Load Dependencies.
+~~~~~~~~~~~~~~~~~~
+
+Files may be unloaded only in the strict reverse order of loading. This is enforced by the
+configuration system.
+
+This is to ensure that any load dependencies are maintained.
+
+A configuration file that contains a CONFIG_ELEM that references named features "feat_A" and "feat_B" will load only if either:-
+a) "feat_A" and/or "feat_B" has been loaded previously, or are present as built-in / module loaded features.
+b) "feat_A" and/or "feat_B" are declared as FEAT_ELEM in the same file as the CONFIG_ELEM.
+
+Files that contain features or configurations with the same names as those already loaded will fail to load.
-- 
2.17.1

